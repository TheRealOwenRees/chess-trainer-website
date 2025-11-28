defmodule ChessTrainer.TablebaseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  a tablebase struct via the `ChessTrainer.Endgames.Tablebase` context.
  """

  alias ChessTrainer.Endgames.Tablebase.Parser

  @tablebase_win_json "test/support/fixtures/tablebase_fixtures/tablebase_win.json"
  @tablebase_non_endgame_json "test/support/fixtures/tablebase_fixtures/tablebase_non_endgame.json"

  def tablebase_win do
    @tablebase_win_json
    |> map_to_struct()
  end

  def tablebase_non_endgame do
    @tablebase_non_endgame_json
    |> map_to_struct()
  end

  defp map_to_struct(map) do
    map
    |> File.read!()
    |> Jason.decode!()
    |> Parser.from_map()
  end
end
