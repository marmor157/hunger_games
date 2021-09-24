defmodule HungerGamesWeb.Schema do
  use Absinthe.Schema

  alias HungerGamesWeb.Schema

  # Scalars
  import_types(Schema.RRuleTypes)

  # Types
  import_types(Absinthe.Type.Custom)

  import_types(Schema.ClassTypes)
  import_types(Schema.LecturerTypes)
  import_types(Schema.ScheduleTypes)
  import_types(Schema.StudentTypes)
  import_types(Schema.SystemTypes)

  # Queries

  import_types(HungerGamesWeb.Schema.StudentQueries)
  import_types(HungerGamesWeb.Schema.SystemQueries)

  query do
    import_fields(:student_queries)
    import_fields(:system_queries)
  end

  def context(ctx) do
    Map.put(ctx, :loader, HungerGamesWeb.Dataloader.loader())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end
end
