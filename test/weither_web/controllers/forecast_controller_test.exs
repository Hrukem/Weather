defmodule WeitherWeb.ForecastControllerTest do
  use ExUnit.Case, async: false
  use WeitherWeb.ConnCase

  @get_assert "<h3> Прогноз погоды в Электростали </h3> <br>\n    <h4> выберите на какой день от сегодняшней даты Вы хотите узнать погоду </h4>"
  @post_assert1 "<h3> Прогноз погоды в Электростали </h3> <br>\n    через         1 день <br>\n    утро:         13.05 <br>\n    день:         21.37  <br>\n    вечер:        19.88  <br>\n    ночь:         14.21<br>\n    минимальная:  10.96  <br>\n    максимальная: 21.37  <br>"
  @post_assert2 "<h3> Прогноз погоды в Электростали </h3> <br>\n    через         4 дня <br>\n    утро:         13.78 <br>\n    день:         19.58  <br>\n    вечер:        20.03  <br>\n    ночь:         15.68<br>\n    минимальная:  13.71  <br>\n    максимальная: 20.03  <br>"
  @post_assert3 "<h3> Прогноз погоды в Электростали </h3> <br>\n    через         7 дней <br>\n    утро:         14.81 <br>\n    день:         21.11  <br>\n    вечер:        23.13  <br>\n    ночь:         16.67<br>\n    минимальная:  10.49  <br>\n    максимальная: 28.16  <br>"

  test "GET forecast", %{conn: conn} do
    conn = get(conn, Routes.forecast_path(conn, :show, []))
    assert html_response(conn, 200) =~ @get_assert
  end

  test "POST forecast", %{conn: conn} do
    conn = post(conn, Routes.forecast_path(conn, :show), %{"num_day" => "1"})
    assert String.contains?(conn.resp_body, @post_assert1)
    conn = post(conn, Routes.forecast_path(conn, :show), %{"num_day" => "4"})
    assert String.contains?(conn.resp_body, @post_assert2)
    conn = post(conn, Routes.forecast_path(conn, :show), %{"num_day" => "7"})
    assert String.contains?(conn.resp_body, @post_assert3)
  end
end
