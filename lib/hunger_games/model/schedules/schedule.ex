defmodule HungerGames.Schedules.Schedule do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{AssignedSchedules.AssignedSchedule, Classes.Class, Requests.Request}

  @type t :: %__MODULE__{
          id: id(),
          name: String.t(),
          registration_end_date: DateTime.t(),
          classes: [Class.t()] | Ecto.Association.NotLoaded.t(),
          requests: [Request.t()] | Ecto.Association.NotLoaded.t(),
          assigned_schedules: [AssignedSchedule.t()] | Ecto.Association.NotLoaded.t()
        }

  @required_keys [:name, :registration_end_date]
  @optional_keys []

  schema "schedules" do
    field :name, :string
    field :registration_end_date, :utc_datetime_usec

    has_many :classes, Class
    has_many :assigned_schedules, AssignedSchedule
    has_many :requests, Request

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
