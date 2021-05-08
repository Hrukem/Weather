defmodule WeitherWeb.HistoryController do
  use WeitherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"historydate" => historydate}) do
    %{"day" => day, "month" => month, "year" => year} = historydate

    month = if (String.to_integer(month)) < 10, do: "0"<>month, else: month
    day = if (String.to_integer(day)) < 10, do: "0"<>day, else: day

    request_repo = (year <> "-" <> month <> "-" <> day)

    all_data = Weither.Repo.get_data(request_repo)

    selectivly_data = Enum.map(all_data, fn x -> Map.take(x, [:humidity, :pressure, :temp, :wind_speed]) end)

    render(conn, "show.html", selectivly_data: selectivly_data)
  end

end
