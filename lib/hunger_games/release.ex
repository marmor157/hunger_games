defmodule HungerGames.Release do
  require Logger

  @app :hunger_games

  @spec migrate() :: boolean()
  def migrate do
    repos()
    |> Enum.map(fn repo ->
      result = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
      {repo, result}
    end)
    |> Enum.map(fn {repo, migration_result} ->
      with {:ok, _return, _started_apps} <- migration_result do
        Logger.info("#{repo} successfully migrated")
      end
    end)
    |> Enum.any?(&match?({:error, _}, &1))
    |> Kernel.not()
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end
end
