defmodule WeitherWeb.PageControllerTest do
  use WeitherWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  test "weather", %{conn: conn} do
    conn = get(conn, "weather?type=history&num=4")
    assert html_response(conn, 200) =~ "4 дней назад температура была"
    
    conn = get(conn, "weather?type=forecast&num=4")
    assert html_response(conn, 200) =~ "через 4 дней температура будет"
  end
end
