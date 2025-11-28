defmodule ChessTrainer.Cache do
  @moduledoc """
   Generic LRU cache.

  ## Examples

      iex> start_link(:tablebase)
  """

  use GenServer

  @max_size 2

  # TODO LRU / max size
  # backup ets to dets and seed from backup

  def start_link(table), do: GenServer.start_link(__MODULE__, table, name: via_tuple(table))
  def put(table, key, value), do: GenServer.call(via_tuple(table), {:put, key, value})
  def get(table, key), do: GenServer.call(via_tuple(table), {:get, key})
  def delete(table, key), do: GenServer.call(via_tuple(table), {:delete, key})

  def show(table) do
    ensure_table(table)

    :ets.tab2list(table)
    |> IO.inspect(label: "Cache contents")
  end

  def size(table), do: :ets.info(table, :size)

  @impl true
  def init(table) do
    create_table(table)
    {:ok, table}
  end

  @impl true
  def handle_call({:put, key, value}, _from, table) do
    ensure_table(table)
    timestamp = System.system_time(:millisecond)
    :ets.insert(table, {key, value, timestamp})
    {:reply, :ok, table}
  end

  @impl true
  def handle_call({:get, key}, _from, table) do
    ensure_table(table)

    case :ets.lookup(table, key) do
      [{^key, value, _old_timestamp}] ->
        timestamp = System.system_time(:millisecond)
        :ets.insert(table, {key, value, timestamp})
        {:reply, {:ok, value}, table}

      [] ->
        {:reply, :error, table}
    end
  end

  @impl true
  def handle_call({:delete, key}, _from, table) do
    :ets.delete(table, key)
    {:reply, :ok, table}
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
