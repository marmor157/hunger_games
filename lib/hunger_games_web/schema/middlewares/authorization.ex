defmodule HungerGamesWeb.Schema.Middleware.Authorization do
  @behaviour Absinthe.Middleware

  alias HungerGames.Students.Student

  @impl true
  def call(%{context: %{current_user: nil}} = resolution, _options) do
    Absinthe.Resolution.put_result(resolution, {:error, :unauthorized})
  end

  @impl true
  def call(%{context: %{current_user: %Student{}}} = resolution, _options) do
    resolution
  end
end
