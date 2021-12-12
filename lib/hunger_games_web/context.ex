defmodule HungerGamesWeb.Context do
  @behaviour Plug

  import Plug.Conn

  alias HungerGamesWeb.Auth.Student, as: AuthStudent

  def init(opts), do: opts

  def call(conn, _) do
    build_context(conn)
  end

  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization") do
      context = context(%{token: token})
      Absinthe.Plug.put_options(conn, context: context)
    else
      _ -> Absinthe.Plug.put_options(conn, context: context(%{}))
    end
  end

  def context(params) do
    %{} |> Map.put(:current_user, authorize(params))
  end

  defp authorize(%{token: token}) do
    case AuthStudent.verify_token(token) do
      {:ok, student} -> student
      {:error, _reason} -> nil
    end
  end

  defp authorize(_), do: nil
end
