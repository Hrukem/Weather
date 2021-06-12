defmodule WeitherWeb.HistoryControllerTest do
  use ExUnit.Case, async: false
  use WeitherWeb.ConnCase

  test "GET /history", %{conn: conn} do
    conn = get(conn, "/history")
    assert html_response(conn, 200) =~ 
      "<h3> История погоды в Электростали </h3> <br>\n    <h4> Введите начало периода за который хотите узнать погоду </h4>"
    assert html_response(conn, 200) =~ "<h4> Введите конец периода за который хотите узнать погоду </h4>"
  end

  test "POST /history", %{conn: conn} do
    conn = post(conn, Routes.history_path(conn, :show), %{"historydate_start" => %{"day" => "5", "month" => "6", "year" => "2021", "hour" => "0", "minute" => "0", "second" => "0"}, "historydate_end" => %{"day" => "7", "month" => "6", "year" => "2021", "hour" => "0", "minute" => "0", "second" => "0"}})
    assert String.contains?(conn.resp_body, " ")
  end
end
