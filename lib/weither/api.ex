defmodule Weither.Api do
  require Logger

  @doc """
  показывает температуру которая бвла 'num' дней назад от сегодняшней даты
  """
  def get(:history, date) do
    Weither.HttpRequest.request_history(date)
  end

  @doc """
  возвращает прогноз погоды на 'num'-ный день от сегодняшней даты
  """
  def get(:forecast, num) do
    if num in 0..7 do
      Weither.HttpRequest.request_forecast(num)
    else 
      "Error. The num in the request must be less than or equal to 7"
    end
  end

  def get(:current) do
    case Weither.HttpRequest.request_current() do
      {:ok, _x} -> :ok
      {:error, message} ->
        Logger.warn("Error in HttpRequest.request_current(): #{inspect(message)}")
    end
  end
end
