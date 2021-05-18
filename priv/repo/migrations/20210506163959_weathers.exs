defmodule Weither.Repo.Migrations.Weathers do
  use Ecto.Migration

  def change do
    create table(:weathers) do
      add :time_answer, :naive_datetime, unique: true
      add :humidity, :integer
      add :pressure, :integer
      add :temp, :float
      add :wind_speed, :integer

      timestamps()
    end

  create unique_index(:weathers, [:time_answer])
  end
end
