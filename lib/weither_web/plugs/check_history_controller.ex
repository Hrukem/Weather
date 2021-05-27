defmodule WeitherWeb.Plugs.CheckHistoryController do
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

    #проверяем что введенные пользователем на сайте даты и периоды валидны
    #и отправляем данные в history_controller
    #если ошибка - отправляем сообщение об ошибке на страницу ввода периода дат
    with {:ok, start_period_naive} <- NaiveDateTime.from_iso8601(start_period),
         {:ok, end_period_naive}   <- NaiveDateTime.from_iso8601(end_period),
         :lt  <- NaiveDateTime.compare(start_period_naive, end_period_naive) do
      assign(conn, :period, [start_period, end_period])
    else
      {:error, :invalid_date} ->
        send_message_error(conn, "Вы ввели несуществующую дату")
      :gt ->
        send_message_error(conn, "Вы указали начало периода позже конца периода")
      :eq ->
        send_message_error(conn, "Указанные начало и конец периода совпадают")
    end
  end

  defp send_message_error(conn, message) do
    conn 
    |> Phoenix.Controller.put_flash(:error, "#{message}") 
    |> Phoenix.Controller.redirect(to: "/history") 
    |> halt()
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
