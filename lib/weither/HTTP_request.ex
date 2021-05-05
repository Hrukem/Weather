defmodule Weither.HTTPRequest do
  @sec_day 86400

  @doc """
  запрашивает погоду которая была num дней назад от сегодняшней даты
  """
  def request_history(num) do
    day_request1 = time_unix(num) |> to_string()
    
    request = "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=55.784445&lon=38.444849&dt="<>day_request1<>"&appid=a227de41216dd4ea34ad99279b3f6688&units=metric"

    answer = HTTPoison.get! request
    history_weather = Jason.decode!(answer.body)

    (history_weather["current"])["temp"] |> to_string()
  end

  @doc """
  запрашивает прогноз погоды на num-ый день от сегодняшней даты
  """
  def request_forecast(num) do
    request = "https://api.openweathermap.org/data/2.5/onecall?lat=55.784445&lon=38.444849&exclude=alerts,hourly,minutely,current&appid=a227de41216dd4ea34ad99279b3f6688&units=metric"

    answer = HTTPoison.get! request
    forecast_day = Jason.decode!(answer.body)

    (forecast_day["daily"] |> Enum.at(num))["temp"] 
    |> URI.encode_query() 
    |> String.replace("&", "\n")
  end

  @doc """
  запрашивает прогноз погоды на текущий день
  """
  def request_current() do
    request = "https://api.openweathermap.org/data/2.5/onecall?lat=55.784445&lon=38.444849&exclude=alerts,hourly,minutely,daily&appid=a227de41216dd4ea34ad99279b3f6688&units=metric"

    answer = HTTPoison.get! request
    current = Jason.decode!(answer.body)

    %{
      "dt" => date,
      "temp" => temp,
      "humidity" => humidity,
      "pressure" => pressure, 
      "wind_speed" => wind_speed
    } = current["current"]

    weather_current = 
      %{
        "date" => date,
        "temp" => temp, 
        "humidity" => humidity, 
        "pressure" => pressure,
        "wind_speed" => wind_speed
      }

    Weither.Data.create_data(weather_current)
    "Данные в базе"
  end

  defp time_unix(num) do
    t_unix = DateTime.utc_now() |> DateTime.to_unix()
    t_unix - num * @sec_day
  end
end
