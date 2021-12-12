defmodule HungerGamesWeb.Schema.StudentQueries do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.Middleware

  object :student_queries do
    field :me, type: :student do
      middleware(Middleware.Authorization)
      resolve(fn _parent, _args, %{context: %{current_user: me}} -> {:ok, me} end)
    end
  end
end
