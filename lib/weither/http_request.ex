defmodule Weither.HttpRequest do

  @pa_mmrs 0.750062

  @doc """
  запрашивает погоду которая была num дней назад от сегодняшней даты
  """
  def request_history(date) do
    Weither.Data.get_data(date) 
    |> Enum.map(fn x -> Map.take(x, [:humidity, :pressure, :temp, :wind_speed]) end)
  end

  @doc """
  запрашивает прогноз погоды на num-ый день от сегодняшней даты
  """
  def request_forecast(num) do
    request = "https://api.openweathermap.org/data/2.5/onecall?lat=55.784445&lon=38.444849&exclude=alerts,hourly,minutely,current&appid=a227de41216dd4ea34ad99279b3f6688&units=metric"

    case HTTPoison.get request do
      {:ok, answer_map} ->
        case answer_map.status_code do
          200 ->
            with {:ok, weather} <- body_decode(answer_map.body) do
              (weather["daily"] |> Enum.at(num))["temp"] 
            end
          _ ->
            {:error, answer_map.status_code}
        end

      {:error, _x} ->
        {:error, :error_server}    
    end
  end

  @doc """
  запрашивает прогноз погоды на текущий день
  """
  def request_current() do
    request = "https://api.openweathermap.org/data/2.5/onecall?lat=55.784445&lon=38.444849&exclude=alerts,hourly,minutely,daily&appid=a227de41216dd4ea34ad99279b3f6688&units=metric"

    case HTTPoison.get request do
      {:ok, answer_map} ->
        case answer_map.status_code do
          200 ->
            with {:ok, weather} <- body_decode(answer_map.body) do
              parse_map(weather) 
              |> put_database()
            end
          _ ->
            {:error, answer_map.status_code}
        end

      {:error, _x} ->
        {:error, :error_server}    
    end
  end

  defp put_database(weather_current) do
    case Weither.Data.create_data(weather_current) do
      {:ok, _x} ->
        {:ok, :ok}
      {:error, _x} ->
        {:error, :error_database}
    end
  end

  defp parse_map(weather) do
    %{
      "dt" => date,
      "temp" => temp,
      "humidity" => humidity,
      "pressure" => pressure, 
      "wind_speed" => wind_speed
    } = weather["current"]

    time_answer =
      DateTime.from_unix!(date) 
      |> DateTime.to_naive()

    pressure = round(pressure * @pa_mmrs)

    %{
      "time_answer" => time_answer,
      "temp" => temp, 
      "humidity" => humidity, 
      "pressure" => pressure,
      "wind_speed" => wind_speed
    }
  end

  defp body_decode(body) do
    case Jason.decode(body) do
      {:ok, current_weather} ->
        {:ok, current_weather}

      {:error, _x} ->
        {:error, :bad_body}        
    end
  end

end
