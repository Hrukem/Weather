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

    num_day =
      case num_day do
        "1" -> "1 день"
        "2" -> "2 дня"
        "3" -> "3 дня"
        "4" -> "4 дня"
        "5" -> "5 дней"
        "6" -> "6 дней"
        "7" -> "7 дней"
      end
    render(conn, "show.html", 
      num_day: num_day,
      morn:    morn,
      day:     day,
      eve:     eve,
      night:   night,
      min:     min,
      max:     max
    )
  end
end
