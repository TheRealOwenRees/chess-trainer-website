defmodule ChessTrainerWeb.Board.SquareComponentTest do
  use ChessTrainerWeb.ConnCase, async: true

  alias ChessTrainerWeb.Board.SquareComponent

  describe "unit test helpers" do
    test "background returns white when sum of indices is odd" do
      assert SquareComponent.background(0, 1) == "bg-boardwhite"
      assert SquareComponent.background(1, 0) == "bg-boardwhite"
    end

    test "background returns black when sum of indices is even" do
      assert SquareComponent.background(0, 0) == "bg-boardblack"
      assert SquareComponent.background(1, 1) == "bg-boardblack"
    end

    test "highlight_square returns ring classes when true" do
      assert SquareComponent.highlight_square(true) == "ring-inset ring-2 ring-yellow-400"
    end

    test "highlight_square returns empty string when false" do
      assert SquareComponent.highlight_square(false) == ""
    end
  end
end
