defmodule HungerGames.Classes.Class do
  use HungerGames.Schema
  import Ecto.Changeset

  schema "classes" do
    field :name, :string
    field :rrule, :string
    field :size_limit, :integer
    field :type, :string

    many_to_many :students, HungerGames.Students.Student, join_through: "students_classes"

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:name, :type, :size_limit, :rrule])
    |> validate_required([:name, :type, :size_limit, :rrule])
  end
end
