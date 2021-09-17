defmodule HungerGamesWeb.Schema.SystemQueries do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.SystemResolvers

  object :system_queries do
    @desc """
    Get system status.
    """
    field :system, non_null(:system) do
      resolve(&SystemResolvers.get_system_status/3)
    end
  end
end
