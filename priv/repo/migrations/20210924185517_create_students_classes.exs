defmodule HungerGames.Repo.Migrations.CreateStudentsClasses do
  use Ecto.Migration

  def change do
    create table(:students_classes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :student_id, references(:students, type: :binary_id, null: false)
      add :class_id, references(:classes, type: :binary_id, null: false)

      timestamps(type: :utc_datetime_usec)
    end

    create index(:students_classes, [:student_id])
    create index(:students_classes, [:class_id])

    create unique_index(:students_classes, [:student_id, :class_id])
  end
end
