defmodule HungerGamesWeb.Auth.Guardian do
  use Guardian, otp_app: :hunger_games

  alias HungerGames.Students

  def subject_for_token(%{student_id: student_id}, _claims) do
    {:ok, student_id}
  end

  def resource_from_claims(%{"sub" => student_id}) when is_binary(student_id) do
    case Students.get_student(student_id) do
      nil ->
        {:errors, :student_not_found}

      user ->
        {:ok, user}
    end
  end
end
