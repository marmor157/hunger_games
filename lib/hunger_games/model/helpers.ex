defmodule HungerGames.Model.Helpers do
  @spec unpack_transaction(
          {:ok, any()}
          | {:error, Ecto.Multi.name(), any(), %{required(Ecto.Multi.name()) => any()}},
          atom()
        ) :: {:ok, any()} | {:error, any()}
  def unpack_transaction(transaction, key) do
    case transaction do
      {:ok, map} -> {:ok, Map.get(map, key)}
      {:error, _stage, reason, _changes} -> {:error, reason}
    end
  end
end
