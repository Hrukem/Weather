defmodule Weither.Weither.Weather do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weathers" do
    field :time_answer, :naive_datetime
    field :humidity, :integer
    field :pressure, :integer
    field :temp, :float
    field :wind_speed, :integer

    timestamps()
  end

  @doc false
  def changeset(weather, attrs) do
    weather
    |> cast(attrs, [:time_answer, :temp, :humidity, :pressure, :wind_speed])
    |> validate_required([:time_answer, :temp, :humidity, :pressure, :wind_speed])
  end
end
