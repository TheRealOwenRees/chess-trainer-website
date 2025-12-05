defmodule ChessTrainer.FENTest do
  use ExUnit.Case, async: true

  alias ChessTrainer.FEN

  describe "color_from_fen/1 - calculate player color" do
    test "white" do
      color = FEN.color_from_fen("8/8/3k4/8/8/3K1R2/8/8 w - - 0 1")
      assert color == :white
    end

    test "black" do
      color = FEN.color_from_fen("6k1/5p2/6p1/8/7p/8/6PP/6K1 b - - 0 0")
      assert color == :black
    end

    test "nil" do
      color = FEN.color_from_fen("6k1/5p2/6p1/8/7p/8/6PP/6K")
      assert is_nil(color)
    end
  end
end
