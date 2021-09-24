defmodule HungerGames.Lecturers do
  @moduledoc """
  The Lecturers context.
  """

  import Ecto.Query, warn: false
  alias HungerGames.Repo

  alias HungerGames.Lecturers.Lecturer

  @doc """
  Returns the list of lecturers.

  ## Examples

      iex> list_lecturers()
      [%Lecturer{}, ...]

  """
  def list_lecturers do
    Repo.all(Lecturer)
  end

  @doc """
  Gets a single lecturer.

  Raises `Ecto.NoResultsError` if the Lecturer does not exist.

  ## Examples

      iex> get_lecturer!(123)
      %Lecturer{}

      iex> get_lecturer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lecturer!(id), do: Repo.get!(Lecturer, id)

  @doc """
  Creates a lecturer.

  ## Examples

      iex> create_lecturer(%{field: value})
      {:ok, %Lecturer{}}

      iex> create_lecturer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lecturer(attrs \\ %{}) do
    %Lecturer{}
    |> Lecturer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lecturer.

  ## Examples

      iex> update_lecturer(lecturer, %{field: new_value})
      {:ok, %Lecturer{}}

      iex> update_lecturer(lecturer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lecturer(%Lecturer{} = lecturer, attrs) do
    lecturer
    |> Lecturer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a lecturer.

  ## Examples

      iex> delete_lecturer(lecturer)
      {:ok, %Lecturer{}}

      iex> delete_lecturer(lecturer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lecturer(%Lecturer{} = lecturer) do
    Repo.delete(lecturer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lecturer changes.

  ## Examples

      iex> change_lecturer(lecturer)
      %Ecto.Changeset{data: %Lecturer{}}

  """
  def change_lecturer(%Lecturer{} = lecturer, attrs \\ %{}) do
    Lecturer.changeset(lecturer, attrs)
  end
end
