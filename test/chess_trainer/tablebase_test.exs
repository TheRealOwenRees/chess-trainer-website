defmodule ChessTrainer.TablebaseTest do
  use ExUnit.Case

  alias ChessTrainer.Endgames.Tablebase
  alias ChessTrainer.TablebaseFixtures

  describe "Parser.from_map/1" do
    test "parses a winning tablebase JSON into a struct" do
      {:ok, tb} = TablebaseFixtures.tablebase_win()

      assert %Tablebase{} = tb
      assert tb.category == :win
    end

    test "parses non-endgame struct" do
      {:ok, tb} = TablebaseFixtures.tablebase_non_endgame()

      assert %Tablebase{} = tb
      assert tb.category == :unknown
    end
  end
end
