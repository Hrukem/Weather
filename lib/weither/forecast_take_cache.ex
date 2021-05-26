defmodule Weither.ForecastTakeCache do
  @doc """
  берёт прогноз погоды на num-ый день из кэша (ETS)
  """
  def take_forecast(num) do
    [{_key, weather}] = :ets.lookup(:forecast_caching, num)
    weather
  end
end
