defmodule WeitherWeb.PageControllerTest do
  use WeitherWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ 
    "Сайт для ознакомления с погодой в Электростали"
  end
end
