defmodule HungerGames.Repo.Migrations.AddRegistrationStartDateSchedule do
  use Ecto.Migration

  def change do
    alter table(:schedules) do
      add :registration_start_date, :utc_datetime_usec, default: fragment("now()::timestamp"), null: false
    end
  end
end
