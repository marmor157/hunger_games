defmodule HungerGames.Schedules do
  @moduledoc """
  The Schedules context.
  """

  import Ecto.Query, warn: false
  import HungerGames.Model.Helpers

  alias Ecto.Multi
  alias HungerGames.Repo
  alias HungerGames.Schedules.Schedule

  @doc """
  Returns the list of schedules.

  ## Examples

      iex> list_schedules()
      [%Schedule{}, ...]

  """
  def list_schedules do
    Repo.all(Schedule)
  end

  def list_schedules_by_creator(owner_id) do
    from(Schedule)
    |> where([s], s.creator_id == ^owner_id)
    |> Repo.all()
  end

  @doc """
  Gets a single schedule.

  Raises `Ecto.NoResultsError` if the Schedule does not exist.

  ## Examples

      iex> get_schedule!(123)
      %Schedule{}

      iex> get_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_schedule!(id), do: Repo.get!(Schedule, id)
  def get_schedule(id), do: Repo.get(Schedule, id)

  @doc """
  Creates a schedule.

  ## Examples

      iex> create_schedule(%{field: value})
      {:ok, %Schedule{}}

      iex> create_schedule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_schedule(attrs \\ %{}) do
    Multi.new()
    |> Multi.insert(:insert_schedule, Schedule.changeset(%Schedule{}, attrs))
    |> Multi.run(:insert_oban_job, fn _repo, %{insert_schedule: schedule} ->
      HungerGames.AssignScheduleWorker.enqueue_schedule(schedule)
    end)
    |> Repo.transaction()
    |> unpack_transaction(:insert_schedule)
  end

  @doc """
  Updates a schedule.

  ## Examples

      iex> update_schedule(schedule, %{field: new_value})
      {:ok, %Schedule{}}

      iex> update_schedule(schedule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_schedule(%Schedule{} = schedule, attrs) do
    schedule
    |> Schedule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a schedule.

  ## Examples

      iex> delete_schedule(schedule)
      {:ok, %Schedule{}}

      iex> delete_schedule(schedule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_schedule(%Schedule{} = schedule) do
    Repo.delete(schedule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking schedule changes.

  ## Examples

      iex> change_schedule(schedule)
      %Ecto.Changeset{data: %Schedule{}}

  """
  def change_schedule(%Schedule{} = schedule, attrs \\ %{}) do
    Schedule.changeset(schedule, attrs)
  end
end
