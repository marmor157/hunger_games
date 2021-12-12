defmodule HungerGamesWeb.Schema.AuthTypes do
  use Absinthe.Schema.Notation

  object :login_payload do
    field :token, non_null(:string)
  end

  input_object :register_input do
    import_fields :base_student
    field :password, non_null(:string)
  end
end
