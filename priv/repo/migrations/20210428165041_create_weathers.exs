defmodule Weither.Repo.Migrations.CreateWeathers do
  use Ecto.Migration

  def change do
    create table(:weathers) do
      add :date, :integer
      add :temp, :float
      add :humidity, :integer
      add :pressure, :integer
      add :wind_speed, :integer

      timestamps()
    end

  end
end
