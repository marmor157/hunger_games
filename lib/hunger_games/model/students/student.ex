defmodule HungerGames.Students.Student do
  use HungerGames.Schema
  import Ecto.Changeset

  alias HungerGames.{AssignedSchedules.AssignedSchedule, Requests.Request, Students.Encryption}

  @type t :: %__MODULE__{
          id: id(),
          name: String.t(),
          email: String.t(),
          requests: [Request.t()] | Ecto.Association.NotLoaded.t(),
          assigned_schedules: [AssignedSchedule.t()] | Ecto.Association.NotLoaded.t(),
          encrypted_password: String.t(),
          password_reset_token: String.t() | nil,
          password_reset_token_expiration_date: DateTime.t() | nil,

          # virtual
          password: String.t() | nil
        }

  @fields [
    :name,
    :email,
    :password,
    :password_reset_token,
    :password_reset_token_expiration_date
  ]

  @create_required_fields [
    :email,
    :password,
    :name
  ]

  @update_required_fields [
    :email,
    :name,
    :encrypted_password
  ]

  schema "students" do
    field :name, :string
    field :email, :string

    field :encrypted_password, :string
    field :password_reset_token, :string
    field :password_reset_token_expiration_date, :utc_datetime

    has_many :requests, Request
    has_many :assigned_schedules, AssignedSchedule

    field :password, :string, virtual: true

    timestamps()
  end

  def create_changeset(student, attrs) do
    student
    |> cast(attrs, @fields)
    |> validate_required(@create_required_fields)
    |> changeset_common()
  end

  def update_changeset(student, attrs) do
    student
    |> cast(attrs, @fields)
    |> validate_required(@update_required_fields)
    |> changeset_common()
  end

  defp changeset_common(changeset) do
    changeset
    |> update_change(:email, &String.downcase/1)
    |> validate_email()
    |> unique_constraint(:email, name: :students_email_index)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      put_change(changeset, :encrypted_password, Encryption.hash_password(password))
    else
      changeset
    end
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/)
  end
end
