defmodule HungerGamesWeb.Schema.AuthMutations do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.AuthResolvers

  object :auth_mutations_root do
    field :login, non_null(:login_payload) do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&AuthResolvers.login/3)
    end

    field :register, non_null(:student) do
      arg(:input, non_null(:register_input))
      resolve(&AuthResolvers.register/3)
    end
  end
end
