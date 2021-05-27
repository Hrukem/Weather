defmodule WeitherWeb.Plugs.CheckGetWeatherController do
  import Plug.Conn

  @regex ~r/\d\d\d\d-\d\d-\d\d_\d\d:\d\d:\d\d,\d\d\d\d-\d\d-\d\d_\d\d:\d\d:\d\d/

  def init(opts), do: opts

  def call(conn, _params) do
    with true <- Map.keys(conn.query_params) == ["num", "type"],
         true <- (conn.query_params["type"] == "history") and 
                   String.match?(conn.query_params["num"], @regex)
                     or
                       (conn.query_params["type"] == "forecast" and 
                         String.match?(conn.query_params["num"], ~r/\d/) and
                           String.to_integer(conn.query_params["num"]) in 0..7)
    do
      conn
    else 
      false -> 
        send_resp(conn, 400, "bad request") |> halt()
    end
  end
end
