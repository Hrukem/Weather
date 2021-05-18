defmodule Weither.Plugs.CheckRouter do

  @request_path ["/", "/weather", "/history", "/forecast", "/dashboard/home", "/live", "/socket"]
  def init(opts), do: opts

  def call(conn, _params) do
    %{request_path: path} = conn
    IO.inspect(path, label: "path")
    if path in @request_path do
      IO.puts("True")
    else
      IO.puts("false")
    end
    conn
  end
end
