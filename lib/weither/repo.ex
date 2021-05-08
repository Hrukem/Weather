defmodule Weither.Repo do
  use Ecto.Repo,
    otp_app: :weither,
    adapter: Ecto.Adapters.Postgres

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  schema "weathers" do
    field :date, :string
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

  def list_weather do
    all(Weither.Repo)
  end

  def insert_data(attrs \\ %{}) do
    %Weither.Repo{}
    |> changeset(attrs)
    |> insert()
  end

  def get_data(date) do
    query = 
      from(
        Weither.Repo,
        where: [date: ^date],
        select: [:temp, :pressure, :humidity, :wind_speed]
      )
    all(query)
  end

end
