defmodule Weither.Api do
  @doc """
  показывает температуру которая бвла 'num' дней назад от сегодняшней даты
  """
  def get(:history, num) do
    if num in 0..5 do
      Weither.HttpRequest.request_history(num)
    else 
      IO.puts("Error num in get(:history, num)")
      "Error. num в запросе должно быть меньше или равно 5"
    end
  end

  @doc """
  возвращает прогноз погоды на 'num'-ный день от сегодняшней даты
  """
  def get(:forecast, num) do
    if num in 0..7 do
      Weither.HttpRequest.request_forecast(num)
    else 
      IO.puts("Error num in get(:forecast, num)")
      "Error. num в запросе должно быть меньше или равно 7"
    end
  end

  def get(:current) do
    Weither.HttpRequest.request_current()
  end
end
