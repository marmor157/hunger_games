defmodule HungerGamesWeb.Schema.SystemTypes do
  use Absinthe.Schema.Notation

  object :system do
    @desc """
    System status, use for healthcheckes.

    This field will always contain string `"ok"`.
    """
    field :status, non_null(:string)

    field :version, non_null(:string)
  end
end
