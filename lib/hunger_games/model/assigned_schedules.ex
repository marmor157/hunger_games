defmodule HungerGames.AssignedSchedules do
  @moduledoc """
  The AssignedSchedules context.
  """

  import HungerGames.Model.Helpers
  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias HungerGames.Repo
  alias HungerGames.AssignedSchedules.AssignedSchedule

  @doc """
  Returns the list of assigned_schedules.

  ## Examples

      iex> list_assigned_schedules()
      [%AssignedSchedule{}, ...]

  """
  def list_assigned_schedules do
    Repo.all(AssignedSchedule)
  end

  def list_assigned_schedules_by_student_id(student_id) do
    from(AssignedSchedule)
    |> where([as], as.student_id == ^student_id)
    |> Repo.all()
  end

  @doc """
  Gets a single assigned_schedule.

  Raises `Ecto.NoResultsError` if the AssignedSchedule does not exist.

  ## Examples

      iex> get_assigned_schedule!(123)
      %AssignedSchedule{}

      iex> get_assigned_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assigned_schedule!(id), do: Repo.get!(AssignedSchedule, id)

  def get_assigned_schedule(id), do: Repo.get(AssignedSchedule, id)

  def get_assigned_schedule_by_student_schedule(student_id, schedule_id) do
    from(AssignedSchedule)
    |> where([as], as.schedule_id == ^schedule_id and as.student_id == ^student_id)
    |> Repo.one()
  end

  @spec create_assigned_schedule(
          :invalid
          | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  @doc """
  Creates a assigned_schedule.

  ## Examples

      iex> create_assigned_schedule(%{field: value})
      {:ok, %AssignedSchedule{}}

      iex> create_assigned_schedule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assigned_schedule(attrs \\ %{})

  def create_assigned_schedule(%{classes: classes} = attrs) when is_list(classes) do
    Multi.new()
    |> Multi.insert(
      :insert_assigned_schedule,
      AssignedSchedule.changeset(%AssignedSchedule{}, attrs)
    )
    |> Multi.insert_all(:insert_all, "assigned_schedule_classes", fn changes ->
      %{
        insert_assigned_schedule: assigned_schedule
      } = changes

      classes
      |> Enum.map(fn class ->
        %{
          id: Ecto.UUID.bingenerate(),
          class_id: class.id |> Ecto.UUID.dump() |> elem(1),
          assigned_schedule_id: assigned_schedule.id |> Ecto.UUID.dump() |> elem(1),
          inserted_at: DateTime.utc_now(),
          updated_at: DateTime.utc_now()
        }
      end)
    end)
    |> Repo.transaction()
    |> unpack_transaction(:insert_assigned_schedule)
  end

  def create_assigned_schedule(attrs) do
    %AssignedSchedule{}
    |> AssignedSchedule.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assigned_schedule.

  ## Examples

      iex> update_assigned_schedule(assigned_schedule, %{field: new_value})
      {:ok, %AssignedSchedule{}}

      iex> update_assigned_schedule(assigned_schedule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assigned_schedule(%AssignedSchedule{} = assigned_schedule, attrs) do
    assigned_schedule
    |> AssignedSchedule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a assigned_schedule.

  ## Examples

      iex> delete_assigned_schedule(assigned_schedule)
      {:ok, %AssignedSchedule{}}

      iex> delete_assigned_schedule(assigned_schedule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assigned_schedule(%AssignedSchedule{} = assigned_schedule) do
    Repo.delete(assigned_schedule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assigned_schedule changes.

  ## Examples

      iex> change_assigned_schedule(assigned_schedule)
      %Ecto.Changeset{data: %AssignedSchedule{}}

  """
  def change_assigned_schedule(%AssignedSchedule{} = assigned_schedule, attrs \\ %{}) do
    AssignedSchedule.changeset(assigned_schedule, attrs)
  end
end
