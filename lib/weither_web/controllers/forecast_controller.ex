defmodule WeitherWeb.ForecastController do
  use WeitherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"num_day" => num_day}) do
    %{
      "morn"  => morn,
      "day"   => day,
      "eve"   => eve,
      "night" => night,
      "min"   => min,
      "max"   => max
    } = Weither.Api.get(:forecast, String.to_integer(num_day))

    render(conn, "show.html", 
      morn:  morn,
      day:   day,
      eve:   eve,
      night: night,
      min:   min,
      max:   max
    )
  end
end
