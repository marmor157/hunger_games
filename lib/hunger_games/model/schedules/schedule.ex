defmodule HungerGames.Schedules.Schedule do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{
    AssignedSchedules.AssignedSchedule,
    Classes.Class,
    Requests.Request,
    Students.Student
  }

  @type t :: %__MODULE__{
          id: id(),
          name: String.t(),
          registration_end_date: DateTime.t(),
          registration_start_date: DateTime.t(),
          start_date: Date.t(),
          end_date: Date.t(),
          classes: [Class.t()] | Ecto.Association.NotLoaded.t(),
          requests: [Request.t()] | Ecto.Association.NotLoaded.t(),
          assigned_schedules: [AssignedSchedule.t()] | Ecto.Association.NotLoaded.t(),
          creator: Student.t() | Ecto.Association.NotLoaded.t()
        }

  @required_keys [
    :name,
    :registration_end_date,
    :registration_start_date,
    :start_date,
    :end_date,
    :creator_id
  ]
  @optional_keys []

  schema "schedules" do
    field :name, :string
    field :registration_end_date, :utc_datetime_usec
    field :registration_start_date, :utc_datetime_usec
    field :start_date, :date
    field :end_date, :date

    has_many :classes, Class
    has_many :assigned_schedules, AssignedSchedule
    has_many :requests, Request
    belongs_to :creator, Student

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
