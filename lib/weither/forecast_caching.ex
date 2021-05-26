defmodule Weither.ForecastCaching do
  @doc """
  кладёт данные о погоде за 7 дней в кэш (ETS)
  """
  def caching() do
    case Weither.HttpRequest.take_weather_from_websait() do
      {:ok, weather_all} ->
        weather_daily = weather_all["daily"]
        weather_daily = List.delete_at(weather_daily, 0)
        put_ETS(weather_daily, 1)

      {:error, message} ->
        {:error, message}
    end
  end

  defp put_ETS([], _key), do: :ok

  defp put_ETS([h|t], key) do
    :ets.insert(:forecast_caching, {key, h["temp"]})
    put_ETS(t, key + 1)
  end
end
