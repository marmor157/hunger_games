defmodule HungerGames.Repo.Migrations.CreateLecturers do
  use Ecto.Migration

  def change do
    create table(:lecturers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps(type: :utc_datetime_usec)
    end
  end
end
