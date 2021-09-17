defmodule HungerGamesWeb.Schema do
  use Absinthe.Schema

  # Types
  import_types(HungerGamesWeb.Schema.SystemTypes)

  # Queries

  import_types(HungerGamesWeb.Schema.SystemQueries)

  query do
    import_fields(:system_queries)
  end
end
