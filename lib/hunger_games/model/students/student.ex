defmodule HungerGames.Students.Student do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.Classes.Class

  @type t :: %__MODULE__{
          id: id(),
          name: String.t(),
          classes: [Class.t()] | Ecto.Association.NotLoaded.t()
        }

  @required_keys [:name]
  @optional_keys []

  schema "students" do
    field :name, :string

    many_to_many :classes, HungerGames.Classes.Class, join_through: "students_classes"

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
