defmodule ChessTrainer.Cache do
  @moduledoc """
  Generic cache operations.
  """

  use GenServer

  @doc """
  Generic LRU cache.

  ## Examples

      iex> start_link(:tablebase)
  """

  # TODO LRU / max size

  def start_link(table), do: GenServer.start_link(__MODULE__, table, name: via_tuple(table))

  def put(table, key, value), do: GenServer.call(via_tuple(table), {:put, key, value})

  def get(table, key), do: GenServer.call(via_tuple(table), {:get, key})

  @impl true
  def init(table) do
    create_table(table)
    {:ok, table}
  end

  @impl true
  def handle_call({:put, key, value}, _from, table) do
    ensure_table(table)
    :ets.insert(table, {key, value})
    {:reply, :ok, table}
  end

  @impl true
  def handle_call({:get, key}, _from, table) do
    ensure_table(table)

    case :ets.lookup(table, key) do
      [{^key, value}] -> {:reply, {:ok, value}, table}
      [] -> {:reply, :error, table}
    end
  end

  defp via_tuple(table), do: {:via, Registry, {ChessTrainer.CacheRegistry, table}}

  defp ensure_table(table) do
    case :ets.whereis(table) do
      :undefined -> create_table(table)
      _ -> :ok
    end
  end

  defp create_table(table), do: :ets.new(table, [:named_table, :public, :set])
end
