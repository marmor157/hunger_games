defmodule HungerGames.Classes.Class do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{Students.Student, Schedules.Schedule}

  @type t :: %__MODULE__{
          id: id(),
          name: String.t(),
          rrule: String.t(),
          size_limit: Integer.t(),
          type: String.t(),
          students: [Student.t()] | Ecto.Association.NotLoaded.t(),
          schedule: Schedule.t() | Ecto.Association.NotLoaded.t()
        }

  @required_keys [:name, :rrule, :size_limit, :type]
  @optional_keys []

  schema "classes" do
    field :name, :string
    field :rrule, :string
    field :size_limit, :integer
    field :type, :string

    belongs_to :schedule, Schedule

    many_to_many :students, Student, join_through: "students_classes"

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
