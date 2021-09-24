defmodule HungerGames.Students.Student do
  use HungerGames.Schema
  import Ecto.Changeset

  schema "students" do
    field :name, :string

    many_to_many :classes, HungerGames.Classes.Class, join_through: "students_classes"

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
