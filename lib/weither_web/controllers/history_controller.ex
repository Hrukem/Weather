defmodule WeitherWeb.HistoryController do
  use WeitherWeb, :controller

  plug Weither.Plugs.CheckHistoryController when action in [:show]

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(%Plug.Conn{assigns: %{period: [start_period, end_period]}} = conn, _params) do

    answer = Weither.Api.get(:history, start_period, end_period)

    render(conn, "show.html", selectivly_data: answer)
  end

end
