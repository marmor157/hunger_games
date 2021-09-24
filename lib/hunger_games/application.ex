defmodule HungerGames.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      HungerGames.Repo,
      # Start the Telemetry supervisor
      HungerGamesWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HungerGames.PubSub},
      # Start the Endpoint (http/https)
      HungerGamesWeb.Endpoint
      # Start a worker by calling: HungerGames.Worker.start_link(arg)
      # {HungerGames.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HungerGames.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def start_phase(:migrate, :normal, _opts) do
    if HungerGames.Release.migrate() do
      :ok
    else
      {:error, :migration_error}
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HungerGamesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
