defmodule WeitherWeb.ForecastController do
  use WeitherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"num_day" => num_day}) do
    case Weither.Api.get(:forecast, String.to_integer(num_day)) do
      [] -> 
        conn 
        |> Phoenix.Controller.put_flash(:error, 
           "Sorry, there is no data on the weather forecast. Try again later."
           ) 
        |> Phoenix.Controller.redirect(to: "/forecast") 
        |> halt()

      %{} = weather ->
        num_day = get_num_day(num_day)

        render(conn, "show.html", 
          num_day: num_day,
          morn:    Map.get(weather, "morn"),
          day:     Map.get(weather, "day"),
          eve:     Map.get(weather, "eve"),
          night:   Map.get(weather, "night"),
          min:     Map.get(weather, "min"),
          max:     Map.get(weather, "max")
        )
    end
  end
  
  defp get_num_day(num_day) when num_day == "1", do: "1 день"

  defp get_num_day(num_day) when num_day in ["2", "3", "4"], do: "#{num_day} дня"

  defp get_num_day(num_day) when num_day in ["5", "6", "7"], do: "#{num_day} дней"
end
