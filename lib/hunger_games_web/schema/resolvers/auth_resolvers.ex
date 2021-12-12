defmodule HungerGamesWeb.Schema.AuthResolvers do
  alias HungerGames.{Repo, Students}
  alias Students.{Student, Encryption}
  alias HungerGamesWeb.Auth.Student, as: AuthStudent

  def login(_parent, %{email: email, password: password}, _context) do
    student = Repo.get_by(Student, email: email)

    cond do
      is_nil(student) ->
        {:error, :invalid_credentials}

      not Encryption.validate_password(student, password) ->
        {:error, :invalid_credentials}

      true ->
        token = AuthStudent.sign_token(student.id)
        {:ok, %{token: token}}
    end
  end

  def register(_parent, %{input: input}, _context) do
    case Students.create_student(input) do
      {:ok, _} = response ->
        response

      {:error, %Ecto.Changeset{errors: [email: _]}} ->
        {:error, :email_taken}

      error ->
        error
    end
  end
end
