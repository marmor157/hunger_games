defmodule HungerGames.AssignedSchedules.AssignedSchedule do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{
    Classes.Class,
    Students.Student,
    Schedules.Schedule
  }

  @required_keys [:student_id, :schedule_id]
  @optional_keys []

  @type t :: %__MODULE__{
          id: id(),
          student: Student.t() | Ecto.Association.NotLoaded.t(),
          schedule: Schedule.t() | Ecto.Association.NotLoaded.t(),
          classes: [Class.t()] | Ecto.Association.NotLoaded.t()
        }

  schema "assigned_schedules" do
    belongs_to :student, Student
    belongs_to :schedule, Schedule
    many_to_many :classes, Class, join_through: "assigned_schedule_classes"

    timestamps()
  end

  @doc false
  def changeset(assigned_schedule, attrs) do
    assigned_schedule
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
