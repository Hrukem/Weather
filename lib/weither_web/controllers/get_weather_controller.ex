defmodule WeitherWeb.GetWeatherController do
  use WeitherWeb, :controller

  plug WeitherWeb.Plugs.CheckGetWeatherController


  @doc """
  в зависимости от внешнего запроса возвращает историю погоды за указанный период
  или прогноз погоды на указанный день от текущего
  """
  def get(conn, params) do
    IO.inspect(conn, label: "conn")

    type = params["type"]
    num = params["num"]

    case type do
      "history" ->
        [start_period, end_period] = 
          String.replace(num, "_", " ") 
          |> String.split(",")

        #проверяем что введенные пользователем в запросе даты и периоды валидны
        #и отправляем данные в get_weather_controller
        #если ошибка - отправляем сообщение об ошибке пользователю
        with {:ok, start_period_naive} <- NaiveDateTime.from_iso8601(start_period),
             {:ok, end_period_naive}   <- NaiveDateTime.from_iso8601(end_period),
             :lt  <- NaiveDateTime.compare(start_period_naive, end_period_naive) do
          answer =
            Weither.Api.get(:history, start_period, end_period) |> Jason.encode!()

          send_resp(conn, 200, answer)
        else
          {:error, :invalid_date} ->
            send_resp(conn, 401, "You entered a non-existent date")
          :gt ->
            send_resp(conn, 401, "You specified the beginning of the period later than the end of the period")
          :eq ->
            send_resp(conn, 401, "The specified start and end of the period are the same")
        end

      "forecast" ->
        answer = 
          Weither.Api.get(:forecast, String.to_integer(num)) |> Jason.encode!()

        send_resp(conn, 200, answer)
    end
  end
end
