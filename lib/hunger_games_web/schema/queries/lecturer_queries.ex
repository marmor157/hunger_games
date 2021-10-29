defmodule HungerGamesWeb.Schema.LecturerQueries do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.LecturerResolvers

  object :lecturer_queries do
    @desc """
    Get lecturer details
    """
    field :lecturer, type: :lecturer do
      arg(:id, :id)
      resolve(&LecturerResolvers.get_lecturer/3)
    end
  end
end
