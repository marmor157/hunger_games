defmodule HungerGames.SimpleScheduleRequestSolver do
  @moduledoc """
  This is a simplest possible ScheduleRequestSolver.

  It is based on time of requests and does not feature collision detection
  """
  @behaviour HungerGames.ScheduleRequestSolver

  alias HungerGames.{Classes.Class, ClassRequests.ClassRequest, Requests.Request}

  def solve_schedule(schedule) do
    classes =
      schedule.classes
      |> Enum.map(&parse_class/1)
      |> group_by_name_and_type()

    requests =
      schedule.requests
      |> Enum.map(&parse_request/1)
      |> Enum.sort(&(DateTime.compare(&1.date, &2.date) != :gt))

    %{requests: requests, classes: classes}
    |> resolve_requests()
    |> Map.get(:classes)
    |> Map.values()
    |> List.flatten()
  end

  defp parse_class(%Class{} = class) do
    class
    |> Map.take([:name, :id, :rrule, :size_limit, :type])
    |> Map.put(:current_students, [])
  end

  defp parse_request(%Request{} = request) do
    class_requests =
      request.class_requests
      |> Enum.map(&parse_class_request/1)
      |> Enum.sort_by(& &1.priority)
      |> group_by_name_and_type()

    %{
      student_id: request.student_id,
      class_requests: class_requests,
      date: request.date
    }
  end

  defp parse_class_request(%ClassRequest{class_id: class_id, priority: priority, class: class}) do
    %{
      class_id: class_id,
      priority: priority,
      type: class.type,
      name: class.name
    }
  end

  defp group_by_name_and_type(entities) do
    entities
    |> Enum.group_by(fn %{name: name, type: type} ->
      name <> Atom.to_string(type)
    end)
  end

  defp resolve_requests(%{requests: requests} = args) when length(requests) == 0, do: args

  defp resolve_requests(%{requests: requests, classes: classes}) do
    requests
    |> Enum.reduce(%{classes: classes}, fn request, %{classes: classes} ->
      %{
        classes: resolve_request(%{classes: classes, request: request})
      }
    end)
  end

  defp resolve_request(%{classes: classes, request: request}) do
    %{student_id: student_id, class_requests: class_requests} = request

    class_requests
    |> Map.keys()
    |> Enum.map(fn key ->
      classes =
        resolve_subject(%{
          classes: Map.get(classes, key),
          requests: Map.get(class_requests, key),
          student_id: student_id
        })

      {key, classes}
    end)
    |> Map.new()
  end

  defp resolve_subject(%{classes: classes, student_id: student_id} = args) do
    %{class_id: class_id} = get_matching_request(args)

    classes
    |> Enum.map(fn class ->
      if class.id == class_id,
        do: %{class | current_students: [student_id | class.current_students]},
        else: class
    end)
  end

  defp get_matching_request(%{classes: classes, requests: requests}) do
    requests
    |> Enum.find(fn %{class_id: class_id} ->
      case classes
           |> Enum.find(fn class -> class.id == class_id && class_available?(class) end) do
        nil -> false
        _ -> true
      end
    end)
  end

  defp class_available?(%{size_limit: size_limit, current_students: current_students}) do
    size_limit > length(current_students)
  end
end
