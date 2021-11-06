defmodule HungerGames.Students.Student do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{AssignedSchedules.AssignedSchedule, Requests.Request}

  @type t :: %__MODULE__{
          id: id(),
          name: String.t(),
          requests: [Request.t()] | Ecto.Association.NotLoaded.t(),
          assigned_schedules: [AssignedSchedule.t()] | Ecto.Association.NotLoaded.t()
        }

  @required_keys [:name]
  @optional_keys []

  schema "students" do
    field :name, :string

    has_many :requests, Request
    has_many :assigned_schedules, AssignedSchedule

    timestamps()
  end

  def changeset(student, attrs) do
    student
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
