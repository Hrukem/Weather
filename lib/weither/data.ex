defmodule Weither.Data do
  @moduledoc """
  """

  import Ecto.Query, warn: false

  def list_weather do
    Weither.Repo.all(Weither.Weither.Weather)
  end

  def create_data(attrs \\ %{}) do
    %Weither.Weither.Weather{}
    |> Weither.Weither.Weather.changeset(attrs)
    |> Weither.Repo.insert()
  end

  def get_data(date) do
     query = 
       from(
         Weither.Weither.Weather,
         where: [time_answer: ^date],
         select: [:temp, :pressure, :humidity, :wind_speed]
       )
     Weither.Repo.all(query)
   end

end
