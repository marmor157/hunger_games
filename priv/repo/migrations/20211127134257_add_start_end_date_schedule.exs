defmodule HungerGames.Repo.Migrations.AddStartEndDateSchedule do
  use Ecto.Migration

  def change do
    alter table(:schedules) do
      add :start_date, :date, default: fragment("now()::timestamp"), null: false
      add :end_date, :date, default: fragment("now()::timestamp + INTERVAL '5 MONTHS'"), null: false
    end
  end
end
