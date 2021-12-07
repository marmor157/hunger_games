defmodule HungerGames.Students.Encryption do
  alias HungerGames.Students.Student

  def hash_password(password), do: Bcrypt.hash_pwd_salt(password)

  def validate_password(%Student{} = student, password),
    do: Bcrypt.verify_pass(password, student.encrypted_password)
end
