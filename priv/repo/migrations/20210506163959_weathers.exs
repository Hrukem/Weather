defmodule Weither.Repo.Migrations.Weathers do
  use Ecto.Migration

  def change do
    create table(:weathers) do
      add :time_answer, :naive_datetime
      add :humidity, :integer
      add :pressure, :integer
      add :temp, :float
      add :wind_speed, :float

      timestamps()
    end

  create unique_index(:weathers, [:time_answer])
  end
end
