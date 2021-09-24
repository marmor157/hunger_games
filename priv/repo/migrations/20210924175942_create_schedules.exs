defmodule HungerGames.Repo.Migrations.CreateSchedules do
  use Ecto.Migration

  def change do
    create table(:schedules, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps(type: :utc_datetime_usec)
    end
  end
end
