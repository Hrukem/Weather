defmodule WeitherWeb.Plugs.CheckGetWeatherController do
  import Plug.Conn

  @regex ~r/\d\d\d\d-\d\d-\d\d_\d\d:\d\d:\d\d,\d\d\d\d-\d\d-\d\d_\d\d:\d\d:\d\d/

  def init(opts), do: opts

  def call(conn, _params) do
    if check_request(conn) do
      conn
    else 
      send_resp(conn, 400, "bad request") |> halt()
    end
  end

  defp check_request(%Plug.Conn{query_params: %{"type" => "history", "num" => num}}) do
    String.match?(num, @regex)
  end

  defp check_request(%Plug.Conn{query_params: %{"type" => "forecast", "num" => num}}) do
    String.match?(num, ~r/\d/) and
      String.to_integer(num) in 1..7
  end

  defp check_request(%Plug.Conn{query_params: _}) do
    false
  end
end
