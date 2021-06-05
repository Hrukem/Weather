defmodule Weither.HttpRequest do
  require Logger

  @pa_mmrs 0.750062
  @request Application.get_env(:weither, :request)  #смотри config/config.exs

  @doc """
  запрашивает состояние погоды на текущий день на момент запроса
  полученые данные помещает в базу данных weather_dev
  """
  @spec request_weather() :: atom | {atom, atom}
  def request_weather() do
    case take_weather_from_websait() do
      {:ok, weather} ->
        weather
        |> parse_map() 
        |> put_database()

        :ok

      {:error, message} ->
        {:error, message}

    end
  end

  defp put_database(weather_current) do
    case Weither.Data.create_data(weather_current) do
      {:ok, _x} ->
        :ok
      {:error, message} ->
        Logger.error("Error in HttpRequest.put_database(): #{message}")
        {:error, message}
    end
  end

  def parse_map(weather) do
    %{
      "dt"         => date,
      "temp"       => temp,
      "humidity"   => humidity,
      "pressure"   => pressure, 
      "wind_speed" => wind_speed
    } = weather["current"]

    time_answer =
      date
      |> DateTime.from_unix!() 
      |> DateTime.to_naive()

    #преобразуем давление в милиметры ртутного столба
    pressure = round(pressure * @pa_mmrs)

    %{
      "time_answer" => time_answer,
      "temp"        => temp, 
      "humidity"    => humidity, 
      "pressure"    => pressure,
      "wind_speed"  => wind_speed
    }
  end

  def take_weather_from_websait() do
    with {:ok, %HTTPoison.Response{status_code: 200} = answer_map} <- HTTPoison.get(@request <> Application.get_env(:weither, :secret_weather_api)),
         {:ok, weather} <- Jason.decode(answer_map.body) do
      {:ok, weather}

    else
      {:error, %HTTPoison.Error{} = exception} ->
        Logger.error "Error in HttpRequest.take_weather_from_websait(): #{Exception.message(exception)}"
        {:error, :httppoison_error}
      {:ok, answer_map} -> 
        {:error, answer_map.status_code}
      {:error, %Jason.DecodeError{} = exception} ->
        Logger.error "Error in HttpRequest.body_decode(): #{Exception.message(exception)}"
        {:error, :bad_body}        
    end
  end
end
