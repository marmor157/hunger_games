defmodule HungerGamesWeb.Schema.StudentQueries do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.StudentResolvers

  object :student_queries do
    @desc """
    Get student details
    """
    field :student, type: :student do
      arg(:id, :id)
      resolve(&StudentResolvers.get_student/3)
    end
  end
end
