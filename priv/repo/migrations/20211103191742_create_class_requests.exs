defmodule HungerGames.Repo.Migrations.CreateClassRequests do
  use Ecto.Migration

  def change do
    create table(:class_requests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :priority, :integer

      add :class_id, references(:classes, type: :binary_id), null: false
      add :request_id, references(:requests, type: :binary_id), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:class_requests, [:class_id])
    create index(:class_requests, [:request_id])
    create unique_index(:class_requests, [:request_id, :class_id])
  end
end
