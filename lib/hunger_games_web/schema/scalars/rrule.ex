defmodule HungerGamesWeb.Schema.RRuleTypes do
  @moduledoc """
  The rrule scalar type explicitly states which strings are rrule.
  """
  use Absinthe.Schema.Notation

  scalar :rrule, name: "Rrule" do
    description("""
    The `Rrule` scalar type represents rrule string.
    """)

    serialize(& &1)
    parse(&parse_rrule/1)
  end

  defp parse_rrule(%Absinthe.Blueprint.Input.String{value: value}) do
    if String.match?(value, ~r/^[[:alnum:]:;=]*$/), do: value, else: :error
  end

  defp parse_rrule(%Absinthe.Blueprint.Input.Null{}), do: {:ok, nil}
end
