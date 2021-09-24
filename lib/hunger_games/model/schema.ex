defmodule HungerGames.Schema do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :utc_datetime_usec]
      @type id :: Ecto.UUID.t()
    end
  end
end
