defmodule HungerGames.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :type, :string
      add :size_limit, :integer
      add :rrule, :string

      timestamps(type: :utc_datetime_usec)
    end
  end
end
