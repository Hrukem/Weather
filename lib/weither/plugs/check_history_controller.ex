defmodule Weither.Plugs.CheckHistoryController do
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{
    params: %{
      "historydate_start" => 
        %{
          "day" => day_s,
          "month" => month_s,
          "year" => year_s,
          "hour" => hour_s,
          "minute" => minute_s,
          "second" => second_s
        },

      "historydate_end" => 
        %{
          "day" => day_e,
          "month" => month_e,
          "year" => year_e,
          "hour" => hour_e,
          "minute" => minute_e,
          "second" => second_e
        }
    }
  } = conn, _opts) do

    {month_s, day_s, hour_s, minute_s, second_s} =
      check_zero(month_s, day_s, hour_s, minute_s, second_s)

    {month_e, day_e, hour_e, minute_e, second_e} =
      check_zero(month_e, day_e, hour_e, minute_e, second_e)

    start_period = concaten(year_s, month_s, day_s, hour_s, minute_s, second_s)
      end_period = concaten(year_e, month_e, day_e, hour_e, minute_e, second_e)

    assign(conn, :period, [start_period, end_period])
  end

  defp check_zero(month, day, hour, minute, second) do
    month  = if String.to_integer(month) < 10,  do: "0" <> month,  else: month
    day    = if String.to_integer(day) < 10,    do: "0" <> day,    else: day
    hour   = if String.to_integer(hour) < 10,   do: "0" <> hour,   else: hour
    minute = if String.to_integer(minute) < 10, do: "0" <> minute, else: minute
    second = if String.to_integer(second) < 10, do: "0" <> second, else: second

    {month, day, hour, minute, second}
  end

  defp concaten(y, mon, d, h, min, sec) do
      y <> "-" <> mon <> "-" <> d <> " " <>
        h <> ":" <> min <> ":" <> sec
  end
end
