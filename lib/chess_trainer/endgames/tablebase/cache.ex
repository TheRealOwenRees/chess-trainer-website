defmodule ChessTrainer.Endgames.Tablebase.Cache do
  @moduledoc """
  A cache of tablebases by FEN.
  """

  alias ChessTrainer.Cache

  @table :tablebase

  def start, do: Cache.start_link(@table)

  def put(fen, tablebase), do: Cache.put(@table, fen, tablebase)

  def get(fen), do: Cache.get(@table, fen)

  # TODO start link if not started when get/put is called
  # ensure_cache_exists()
end
