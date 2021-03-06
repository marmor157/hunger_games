defmodule HungerGames.Requests do
  @moduledoc """
  The Requests context.
  """

  import HungerGames.Model.Helpers
  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias HungerGames.{ClassRequests.ClassRequest, Repo, Requests.Request}

  @doc """
  Returns the list of requests.

  ## Examples

      iex> list_requests()
      [%Request{}, ...]

  """
  def list_requests do
    Repo.all(Request)
  end

  @doc """
  Gets a single request.

  Raises `Ecto.NoResultsError` if the Class request does not exist.

  ## Examples

      iex> get_request!(123)
      %Request{}

      iex> get_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_request!(id), do: Repo.get!(Request, id)
  def get_request(id), do: Repo.get(Request, id)

  @doc """
  Creates a request.

  ## Examples

      iex> create_request(%{field: value})
      {:ok, %Request{}}

      iex> create_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_request(attrs \\ %{})

  def create_request(%{classes: classes} = attrs) when is_list(classes) do
    Multi.new()
    |> Multi.insert(:insert_request, Request.changeset(%Request{}, attrs))
    |> Multi.insert_all(:insert_all, ClassRequest, fn %{insert_request: request} ->
      classes
      |> Enum.map(fn class ->
        class
        |> Map.put(:request_id, request.id)
        |> Map.put(:inserted_at, DateTime.utc_now())
        |> Map.put(:updated_at, DateTime.utc_now())
      end)
    end)
    |> Repo.transaction()
    |> unpack_transaction(:insert_request)
  end

  def create_request(attrs) do
    %Request{}
    |> Request.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a request.

  ## Examples

      iex> update_request(request, %{field: new_value})
      {:ok, %Request{}}

      iex> update_request(request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_request(%Request{} = request, attrs) do
    request
    |> Request.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a request.

  ## Examples

      iex> delete_request(request)
      {:ok, %Request{}}

      iex> delete_request(request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_request(%Request{} = request) do
    Repo.delete(request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking request changes.

  ## Examples

      iex> change_request(request)
      %Ecto.Changeset{data: %Request{}}

  """
  def change_request(%Request{} = request, attrs \\ %{}) do
    Request.changeset(request, attrs)
  end
end
