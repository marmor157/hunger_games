defmodule HungerGamesWeb.Schema.LecturerMutations do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.LecturerResolvers

  object :lecturer_mutations_root do
    @desc """
    Creates lecturer entity
    """
    field :lecturer_create, non_null(:lecturer) do
      arg(:input, :create_lecturer_input)
      resolve(&LecturerResolvers.create_lecturer/3)
    end
  end
end
