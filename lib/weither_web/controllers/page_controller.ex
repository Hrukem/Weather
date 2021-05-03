defmodule WeitherWeb.PageController do
  use WeitherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
