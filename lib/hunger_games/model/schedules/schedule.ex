defmodule HungerGames.Schedules.Schedule do
  use HungerGames.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: id(),
          name: String.t(),
          classes: [Class.t()] | Ecto.Association.NotLoaded.t()
        }

  @required_keys [:name]
  @optional_keys []

  schema "schedules" do
    field :name, :string

    has_many :classes, HungerGames.Classes.Class

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
