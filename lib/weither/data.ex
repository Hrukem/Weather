defmodule Weither.Data do
  @moduledoc """
  """

  import Ecto.Query, warn: false

  def list_weather do
    Weither.Repo.all(Weither.Scheme.Weather)
  end

  def create_data(attrs \\ %{}) do
    %Weither.Scheme.Weather{}
    |> Weither.Scheme.Weather.changeset(attrs)
    |> Weither.Repo.insert()
  end

  def get_data(date_start, date_end) do
    query = 
      from(
        p in Weither.Scheme.Weather,
        where: p.time_answer >= ^date_start and p.time_answer <= ^date_end,
        select: [p.time_answer, p.temp, p.pressure, p.humidity, p.wind_speed]
      )
    Weither.Repo.all(query)
  end

end
