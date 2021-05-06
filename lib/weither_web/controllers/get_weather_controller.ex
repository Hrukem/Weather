defmodule WeitherWeb.GetWeatherController do
  use WeitherWeb, :controller


  @doc """
  определяем тип запроса: история, прогноз, текущщее(с занемением в базу данных)
  """
  def get(conn, params) do
    type = params["type"]
    num = params["num"]

    answer =
      case type do
        "history" ->
          "#{num} дней назад температура была " <>
          Weither.Api.get(:history, String.to_integer(num))

        "forecast" ->
          "через #{num} дней температура будет " <>
            Weither.Api.get(:forecast, String.to_integer(num))

        "current" ->
          Weither.Api.get(:current)
          
      end

    render(conn, "weather.html", answer: answer)
  end
end
