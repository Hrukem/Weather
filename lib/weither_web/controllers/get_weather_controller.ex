defmodule WeitherWeb.GetWeatherController do
  use WeitherWeb, :controller

  plug Weither.Plugs.CheckGetWeatherController


  @doc """
  определяем тип запроса: история, прогноз
  """
  def get(conn, params) do

    type = params["type"]
    num = params["num"]

    case type do
      "history" ->
        [date_start, date_end] = 
          String.replace(num, "_", " ") 
          |> String.split(",")

        answer =
          (Weither.Api.get(:history, date_start, date_end)
          |> Jason.encode!())

        send_resp(conn, 200, answer)

      "forecast" ->
        answer = 
          Weither.Api.get(:forecast, String.to_integer(num))
          |> Jason.encode!()

        send_resp(conn, 200, answer)
    end
  end
end
