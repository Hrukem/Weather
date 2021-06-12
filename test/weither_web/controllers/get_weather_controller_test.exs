defmodule WeitherWeb.GetWeatherControllerTest do
  use ExUnit.Case, async: false
  use WeitherWeb.ConnCase

  test "GET /weather forecast", %{conn: conn} do
    conn = get(conn, "/weather?type=forecast&num=1")
    assert conn.resp_body == "{\"day\":21.37,\"eve\":19.88,\"max\":21.37,\"min\":10.96,\"morn\":13.05,\"night\":14.21}"
    conn = get(conn, "/weather?type=forecast&num=4")
    assert conn.resp_body == "{\"day\":19.58,\"eve\":20.03,\"max\":20.03,\"min\":13.71,\"morn\":13.78,\"night\":15.68}"
    conn = get(conn, "/weather?type=forecast&num=7")
    assert conn.resp_body == "{\"day\":21.11,\"eve\":23.13,\"max\":28.16,\"min\":10.49,\"morn\":14.81,\"night\":16.67}"

    conn = get(conn, "/weather?type=forecast&num=0")
    assert conn.resp_body == "bad request"
    conn = get(conn, "/weather?type=forecast&num=8")
    assert conn.resp_body == "bad request"
    conn = get(conn, "/weather?type=forecast&num=foo")
    assert conn.resp_body == "bad request"
    conn = get(conn, "/weather?type=foo&num=foo")
    assert conn.resp_body == "bad request"
  end

  
  test "GET /weather history", %{conn: conn} do
    Weither.HttpRequest.request_and_store_weather()
    conn = get(conn, "/weather?type=history&num=2021-06-05_00:00:00,2021-06-07_00:00:00")
    assert conn.resp_body == "[[\"2021-06-06T16:57:10\",18.66,759,92,1.93]]"

    conn = get(conn, "/weather?type=history&num=2021-02-30_00:00:00,2021-05-30_00:00:00")
    assert conn.resp_body == "You entered a non-existent date"
    conn = get(conn, "/weather?type=history&num=2021-05-01_00:00:00,2021-05-01_00:00:00")
    assert conn.resp_body == "The specified start and end of the period are the same"
    conn = get(conn, "/weather?type=history&num=2021-05-10_00:00:00,2021-05-01_00:00:00")
    assert conn.resp_body == "You specified the beginning of the period later than the end of the period"
    conn = get(conn, "/weather?type=history&num=2021_05-01_00:00:00,2021-05-01_00:00:00")
    assert conn.resp_body == "bad request"
  end
end

