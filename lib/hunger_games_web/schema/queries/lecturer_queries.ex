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

    field :list_lecturers, type: non_null(list_of(non_null(:lecturer))) do
      resolve(&LecturerResolvers.list_lecturers/3)
    end
  end
end
