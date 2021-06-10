defmodule WeitherWeb.HistoryControllerTest do
  use ExUnit.Case, async: false
  use WeitherWeb.ConnCase

  test "GET /history", %{conn: conn} do
    conn = get(conn, "/history")
    assert html_response(conn, 200) =~ 
      "<h3> История погоды в Электростали </h3> <br>\n    <h4> Введите начало периода за который хотите узнать погоду </h4>"

    assert html_response(conn, 200) =~ "<h4> Введите конец периода за который хотите узнать погоду </h4>"
  end
end

