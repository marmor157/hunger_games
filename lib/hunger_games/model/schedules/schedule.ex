defmodule HungerGames.Schedules.Schedule do
  use HungerGames.Schema
  import Ecto.Changeset

  schema "schedules" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
