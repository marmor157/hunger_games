defmodule HungerGames.Repo.Migrations.AddLecturerToClass do
  use Ecto.Migration

  def change do
    alter table(:classes) do
      add :lecturer_id, references(:lecturers, type: :binary_id), null: false
    end
  end
end
