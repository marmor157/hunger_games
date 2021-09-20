defmodule HungerGamesWeb.Schema do
  use Absinthe.Schema

  # Types
  import_types(Absinthe.Type.Custom)

  import_types(HungerGamesWeb.Schema.SystemTypes)

  # Queries

  import_types(HungerGamesWeb.Schema.SystemQueries)

  query do
    import_fields(:system_queries)
  end

  def context(ctx) do
    Map.put(ctx, :loader, HungerGamesWeb.Dataloader.loader())
  end
end
