defmodule WeitherWeb.Plugs.CheckGetWeatherController do
  import Plug.Conn

  @regex ~r/\d\d\d\d-\d\d-\d\d_\d\d:\d\d:\d\d,\d\d\d\d-\d\d-\d\d_\d\d:\d\d:\d\d/

  def init(opts), do: opts

  def call(conn, _params) do
    with true <- Map.keys(conn.query_params) == ["num", "type"],
         true <- check_request(conn)
    do
      conn
    else 
      false -> 
        send_resp(conn, 400, "bad request") |> halt()
    end
  end

  defp check_request(%Plug.Conn{query_params: %{"type" => "history"}} = conn) do
    String.match?(conn.query_params["num"], @regex)
  end

  defp check_request(%Plug.Conn{query_params: %{"type" => "forecast"}} = conn) do
    String.match?(conn.query_params["num"], ~r/\d/) and
      String.to_integer(conn.query_params["num"]) in 1..7
  end

  defp check_request(%Plug.Conn{query_params: _}) do
    false
  end
end
