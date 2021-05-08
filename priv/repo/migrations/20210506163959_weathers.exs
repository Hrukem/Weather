defmodule Weither.Repo.Migrations.Weathers do
  use Ecto.Migration

  def change do
    create table(:weathers) do
      add :date, :string
      add :humidity, :integer
      add :pressure, :integer
      add :temp, :float
      add :wind_speed, :integer

      timestamps()
    end

  end
end
