defmodule HungerGames.Repo.Migrations.CreateAssignedScheduleClasses do
  use Ecto.Migration

  def change do
    create table(:assigned_schedule_classes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :schedule_id, references(:schedules, type: :binary_id), null: false
      add :class_id, references(:classes, type: :binary_id), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:assigned_schedule_classes, [:schedule_id])
    create index(:assigned_schedule_classes, [:class_id])

    create unique_index(:assigned_schedule_classes, [:schedule_id, :class_id])
  end
end
