defmodule HungerGamesWeb.Schema.StudentMutations do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.StudentResolvers

  object :student_mutations_root do
    @desc """
    Creates student entity
    """
    field :student_create, non_null(:student) do
      arg(:input, :create_student_input)
      resolve(&StudentResolvers.create_student/3)
    end
  end
end
