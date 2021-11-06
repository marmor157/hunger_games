defmodule HungerGames.Repo.Migrations.CreateAssignedSchedules do
  use Ecto.Migration

  def change do
    create table(:assigned_schedules, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :student_id, references(:students, type: :binary_id), null: false
      add :schedule_id, references(:schedules, type: :binary_id), null: false

      timestamps(type: :utc_datetime_usec)
    end


    create index(:assigned_schedules, [:schedule_id])
    create index(:assigned_schedules, [:student_id])
    create unique_index(:assigned_schedules, [:student_id, :schedule_id])
  end
end
