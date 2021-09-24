defmodule HungerGames.Lecturers.Lecturer do
  use HungerGames.Schema
  import Ecto.Changeset

  schema "lecturers" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(lecturer, attrs) do
    lecturer
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
