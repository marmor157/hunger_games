defmodule HungerGames.ClassRequests.ClassRequest do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{Classes.Class, Requests.Request}

  @type t :: %__MODULE__{
          id: id(),
          priority: Integer.t(),
          request: Request.t() | Ecto.Association.NotLoaded.t(),
          class: Class.t() | Ecto.Association.NotLoaded.t()
        }

  @required_keys [:priority, :request_id, :class_id]
  @optional_keys []

  schema "class_requests" do
    field :priority, :integer

    belongs_to :request, Request
    belongs_to :class, Class

    timestamps()
  end

  @doc false
  def changeset(class_request, attrs) do
    class_request
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
