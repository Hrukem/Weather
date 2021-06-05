defmodule Weither.Api do
  require Logger

  @doc """
  возвращает данные о погоде за переданный период из базы данных
  """
  def get(:history, date_start, date_end) do
    Weither.HistoryFromDatabase.take_history(date_start, date_end)
  end

  @doc """
  возвращает прогноз погоды на 'num'-ный день от сегодняшней даты
  """
  def get(:forecast, num) do
    Weither.Cache.Forecast.get_weather(num)
  end

  @doc """
  запрашивает данные о погоде на стороннем сайте на момент запроса,
  полученные данные помещает в базу данных
  """
  def get(:weather) do
    case Weither.HttpRequest.request_weather() do
      :ok -> 
        :ok

      {:error, message} ->
        Logger.error(
          "Error in HttpRequest.request_weather(): #{inspect(message)}"
        )
        {:error, message}
    end
  end
end
