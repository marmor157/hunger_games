defmodule HungerGames.Repo.Migrations.AddScheduleCreator do
  use Ecto.Migration

  def change do
    alter table(:schedules) do
      add :creator_id, references(:students, type: :binary_id), null: false
    end

    create index(:schedules, [:creator_id])
  end
end
