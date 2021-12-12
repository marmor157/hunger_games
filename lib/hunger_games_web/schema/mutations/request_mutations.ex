defmodule HungerGamesWeb.Schema.RequestMutations do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.RequestResolvers
  alias HungerGamesWeb.Schema.Middleware

  object :request_mutations_root do
    @desc """
    Creates request entity
    """
    field :request_create, non_null(:request) do
      arg(:input, :create_request_input)
      middleware(Middleware.Authorization)
      resolve(&RequestResolvers.create_request/3)
    end
  end
end
