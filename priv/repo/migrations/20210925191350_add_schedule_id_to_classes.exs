defmodule HungerGames.Repo.Migrations.AddScheduleIdToClasses do
  use Ecto.Migration

  def change do
    alter table(:classes) do
      add :schedule_id, references(:schedules, type: :binary_id, null: false)
    end

    create index(:classes, [:schedule_id])
  end
end
