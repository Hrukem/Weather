defmodule WeitherWeb.ForecastController do
  use WeitherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"num_day" => num_day}) do
    answer = Weither.Api.get(:forecast, String.to_integer(num_day))
    IO.inspect(answer)

    render(conn, "show.html")
  end

end
