defmodule HungerGames.Lecturers.Lecturer do
  use HungerGames.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: id(),
          name: String.t()
        }

  @required_keys [:name]
  @optional_keys []

  schema "lecturers" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(lecturer, attrs) do
    lecturer
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
