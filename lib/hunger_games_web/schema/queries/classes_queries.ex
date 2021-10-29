defmodule HungerGamesWeb.Schema.ClassQueries do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.ClassResolvers

  object :class_queries do
    @desc """
    Get class details
    """
    field :class, type: :class do
      arg(:id, :id)
      resolve(&ClassResolvers.get_class/3)
    end
  end
end
