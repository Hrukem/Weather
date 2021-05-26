defmodule Weither.HistoryFromDatabase do

  @doc """
  запрашивает погоду из архива на сервере
  """
  @spec take_history(String.t(), String.t()) :: list
  def take_history(date_start, date_end) do
    Weither.Data.get_data(date_start, date_end)
  end
end
