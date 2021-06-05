defmodule WeitherWeb.HttpTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use Weither.DataCase

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "httpoison" do
    use_cassette "httpoison_get" do
      Weither.HttpRequest.request_weather()

      {:ok, data} = File.read("fixture/vcr_cassettes/httpoison_get.json")
      {:ok, [map]} = Jason.decode(data)
      %{"response" => body_json} = map
      {:ok, body} = Jason.decode(body_json["body"])
      weather_from_request = Weither.HttpRequest.parse_map(body)

      [
        %{
          humidity:    humidity, 
          pressure:    pressure,
          temp:        temp,
          time_answer: time_answer, 
          wind_speed:  wind_speed
        }
      ] = Weither.Data.list_weather()

      weather_from_repo =
        %{
          "humidity"    => humidity, 
          "pressure"    => pressure, 
          "temp"        => temp, 
          "time_answer" => time_answer, 
          "wind_speed"  => wind_speed
        }

      assert weather_from_request == weather_from_repo
    end
  end
end
