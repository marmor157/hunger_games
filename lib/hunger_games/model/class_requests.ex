defmodule HungerGames.ClassRequests do
  @moduledoc """
  The ClassRequests context.
  """

  import Ecto.Query, warn: false
  alias HungerGames.Repo

  alias HungerGames.ClassRequests.ClassRequest

  @doc """
  Returns the list of class_requests.

  ## Examples

      iex> list_class_requests()
      [%ClassRequest{}, ...]

  """
  def list_class_requests do
    Repo.all(ClassRequest)
  end

  @doc """
  Gets a single class_request.

  Raises `Ecto.NoResultsError` if the Class request does not exist.

  ## Examples

      iex> get_class_request!(123)
      %ClassRequest{}

      iex> get_class_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_class_request!(id), do: Repo.get!(ClassRequest, id)

  @doc """
  Creates a class_request.

  ## Examples

      iex> create_class_request(%{field: value})
      {:ok, %ClassRequest{}}

      iex> create_class_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_class_request(attrs \\ %{}) do
    %ClassRequest{}
    |> ClassRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a class_request.

  ## Examples

      iex> update_class_request(class_request, %{field: new_value})
      {:ok, %ClassRequest{}}

      iex> update_class_request(class_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_class_request(%ClassRequest{} = class_request, attrs) do
    class_request
    |> ClassRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a class_request.

  ## Examples

      iex> delete_class_request(class_request)
      {:ok, %ClassRequest{}}

      iex> delete_class_request(class_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_class_request(%ClassRequest{} = class_request) do
    Repo.delete(class_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking class_request changes.

  ## Examples

      iex> change_class_request(class_request)
      %Ecto.Changeset{data: %ClassRequest{}}

  """
  def change_class_request(%ClassRequest{} = class_request, attrs \\ %{}) do
    ClassRequest.changeset(class_request, attrs)
  end
end
