defmodule Weither.Cache.Forecast do
  @doc """
  помещает прогноз погоды на 7 дней в кэш (ETS). 
  обновляется 1 раз в день в 00:00:01
  """
  def init() do
    case Weither.HttpRequest.take_weather_from_websait() do
      {:ok, weather_all} ->
        [_h | weather_daily] = weather_all["daily"]
        put_ets(weather_daily, 1)

      {:error, message} ->
        {:error, message}
    end
  end

  defp put_ets([], _key), do: :ok

  defp put_ets([h|t], key) do
    :ets.insert(:forecast_caching, {key, h["temp"]})
    put_ets(t, key + 1)
  end

  def get_weather(num) do
    case :ets.lookup(:forecast_caching, num) do
      [{_key, weather}] ->
        weather

      [] ->
        init()
        get_weather(num)
    end
  end
end
