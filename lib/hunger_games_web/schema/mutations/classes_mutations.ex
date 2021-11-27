defmodule HungerGamesWeb.Schema.ClassMutations do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.ClassResolvers

  object :class_mutations_root do
    @desc """
    Creates class entity
    """
    field :class_create, non_null(:class) do
      arg(:input, :create_class_input)
      resolve(&ClassResolvers.create_class/3)
    end

    field :class_delete, non_null(:class) do
      arg(:id, :id)
      resolve(&ClassResolvers.delete_class/3)
    end
  end
end
