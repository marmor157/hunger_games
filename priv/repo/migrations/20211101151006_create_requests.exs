defmodule HungerGames.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :utc_datetime_usec

      add :schedule_id, references(:schedules, type: :binary_id), null: false
      add :student_id, references(:students, type: :binary_id), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:requests, [:schedule_id])
    create index(:requests, [:student_id])
    create unique_index(:requests, [:student_id, :schedule_id])
  end
end
