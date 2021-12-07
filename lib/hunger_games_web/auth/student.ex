defmodule HungerGamesWeb.Auth.Student do
  alias HungerGames.Students.Student
  alias HungerGamesWeb.Auth.Guardian

  @spec sign_token(String.t()) :: String.t()
  def sign_token(student_id) do
    ttl = Application.get_env(:hunger_games, Guardian)[:ttl]
    resource = %{student_id: student_id}
    opts = [ttl: {ttl, :seconds}]

    {:ok, token, _claims} = Guardian.encode_and_sign(resource, %{}, opts)

    token
  end

  @spec verify_token(token :: String.t()) :: {:ok, Student.t()} | {:error, any()}
  def verify_token(token) when is_binary(token) do
    case Guardian.resource_from_token(token) do
      {:ok, %Student{} = student, _claims} -> {:ok, student}
      error -> error
    end
  end

  def verify_token(_token) do
    {:error, :invalid_token}
  end
end
