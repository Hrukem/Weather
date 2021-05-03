defmodule Weither.Weither.Weather do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weathers" do
    field :date, :integer
    field :humidity, :integer
    field :pressure, :integer
    field :temp, :float
    field :wind_speed, :integer

    timestamps()
  end

  @doc false
  def changeset(weather, attrs) do
    weather
    |> cast(attrs, [:date, :temp, :humidity, :pressure, :wind_speed])
    |> validate_required([:date, :temp, :humidity, :pressure, :wind_speed])
  end
end
