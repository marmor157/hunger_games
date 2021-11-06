defmodule HungerGames.Classes.Class do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{
    AssignedSchedules.AssignedSchedule,
    ClassRequests.ClassRequest,
    Requests.Request,
    Schedules.Schedule
  }

  @type t :: %__MODULE__{
          id: id(),
          name: String.t(),
          rrule: String.t(),
          size_limit: Integer.t(),
          type: String.t(),
          schedule: Schedule.t() | Ecto.Association.NotLoaded.t(),
          requests: [Request.t()] | Ecto.Association.NotLoaded.t(),
          class_requests: [ClassRequest.t()] | Ecto.Association.NotLoaded.t(),
          assigned_schedules: [AssignedSchedule.t()] | Ecto.Association.NotLoaded.t()
        }

  @required_keys [:name, :rrule, :size_limit, :type, :schedule_id]
  @optional_keys []

  schema "classes" do
    field :name, :string
    field :rrule, :string
    field :size_limit, :integer
    field :type, :string

    belongs_to :schedule, Schedule

    has_many :class_requests, ClassRequest
    many_to_many :requests, Request, join_through: ClassRequest
    many_to_many :assigned_schedules, AssignedSchedule, join_through: "assigned_schedule_classes"

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
