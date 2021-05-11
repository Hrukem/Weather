defmodule WeitherWeb.GetWeatherController do
  use WeitherWeb, :controller

  @doc """
  определяем тип запроса: история, прогноз
  """
  def get(conn, params) do

    type = params["type"]
    num = params["num"]

    case type do
      "history" ->
        answer =
          case NaiveDateTime.from_iso8601(num) do
            {:ok, date} ->
              (Weither.Api.get(:history, date)
              |> Jason.encode!())

            {:error, message} ->
              Jason.encode!(message)
          end

        send_resp(conn, 200, answer)

      "forecast" ->
        answer = 
          Weither.Api.get(:forecast, String.to_integer(num))
          |> Jason.encode!()

        send_resp(conn, 200, answer)
    end
  end

end
