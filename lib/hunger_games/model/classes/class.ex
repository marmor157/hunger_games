defmodule HungerGames.Classes.Class do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{
    AssignedSchedules.AssignedSchedule,
    ClassRequests.ClassRequest,
    Lecturers.Lecturer,
    Requests.Request,
    Schedules.Schedule
  }

  @type types :: :lecture | :exercises | :laboratories | :computer_laboratories | :project

  @type t :: %__MODULE__{
          id: id(),
          name: String.t(),
          rrule: String.t(),
          size_limit: Integer.t(),
          type: types(),
          lecturer: Lecturer.t() | Ecto.Association.NotLoaded.t(),
          schedule: Schedule.t() | Ecto.Association.NotLoaded.t(),
          requests: [Request.t()] | Ecto.Association.NotLoaded.t(),
          class_requests: [ClassRequest.t()] | Ecto.Association.NotLoaded.t(),
          assigned_schedules: [AssignedSchedule.t()] | Ecto.Association.NotLoaded.t()
        }

  @required_keys [:name, :rrule, :size_limit, :type, :schedule_id, :lecturer_id]
  @optional_keys []
  @types [:lecture, :exercises, :laboratories, :computer_laboratories, :project]

  schema "classes" do
    field :name, :string
    field :rrule, :string
    field :size_limit, :integer
    field(:type, Ecto.Enum, values: @types)

    belongs_to :schedule, Schedule
    belongs_to :lecturer, Lecturer

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

  @spec types() :: [types()]
  def types, do: @types
end
