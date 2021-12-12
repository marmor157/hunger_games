defmodule HungerGames.Repo.Migrations.AddStudentPassword do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :email, :string
      add :encrypted_password, :string
      add :password_reset_token, :string, null: true
      add :password_reset_token_expiration_date, :utc_datetime_usec, null: true
    end

    create unique_index(:students, :email)
    create unique_index(:students, :password_reset_token)
  end
end
