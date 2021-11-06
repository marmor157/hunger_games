defmodule HungerGames.Requests.Request do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{
    Classes.Class,
    ClassRequests.ClassRequest,
    Students.Student,
    Schedules.Schedule
  }

  @type t :: %__MODULE__{
          id: id(),
          date: DateTime.t(),
          student_id: Ecto.UUID.t(),
          student: Student.t() | Ecto.Association.NotLoaded.t(),
          schedule_id: Ecto.UUID.t(),
          schedule: Schedule.t() | Ecto.Association.NotLoaded.t(),
          class_requests: [ClassRequest.t()] | Ecto.Association.NotLoaded.t(),
          classes: [Class.t()] | Ecto.Association.NotLoaded.t()
        }

  @required_keys [:date, :student_id, :schedule_id]
  @optional_keys []

  schema "requests" do
    field :date, :utc_datetime_usec

    belongs_to :schedule, Schedule
    belongs_to :student, Student

    has_many :class_requests, ClassRequest

    many_to_many :classes, Class, join_through: ClassRequest

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
