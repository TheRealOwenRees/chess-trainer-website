defmodule ChessTrainer.Cache do
  @moduledoc """
   Generic LRU cache.

  ## Examples

      iex> start_link(:tablebase)
  """

  use GenServer

  @max_size 1000

  # TODO backup ets to dets and seed from backup

  def start_link(table), do: GenServer.start_link(__MODULE__, table, name: via_tuple(table))
  def put(table, key, value), do: GenServer.call(via_tuple(table), {:put, key, value})
  def get(table, key), do: GenServer.call(via_tuple(table), {:get, key})
  def delete(table, key), do: GenServer.call(via_tuple(table), {:delete, key})

  def show(table) do
    ensure_table(table)
    :ets.tab2list(table)
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

    GenServer.cast(self(), :maybe_evict)

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

  @impl true
  def handle_cast(:maybe_evict, table) do
    maybe_evict_oldest(table)
    {:noreply, table}
  end

  defp via_tuple(table), do: {:via, Registry, {ChessTrainer.CacheRegistry, table}}

  defp ensure_table(table) do
    case :ets.whereis(table) do
      :undefined -> create_table(table)
      _ -> :ok
    end
  end

  defp create_table(table), do: :ets.new(table, [:named_table, :public, :set])

  # LRU cache - O(n) time, not efficient
  defp maybe_evict_oldest(table) do
    if :ets.info(table, :size) > @max_size do
      oldest =
        :ets.foldl(
          fn {k, _v, t}, acc ->
            case acc do
              nil -> {k, t}
              {_, oldest_t} when t < oldest_t -> {k, t}
              _ -> acc
            end
          end,
          nil,
          table
        )

      case oldest do
        {oldest_key, _} -> :ets.delete(table, oldest_key)
        _ -> :ok
      end
    end
  end
end
