defmodule ChessTrainerWeb.Board.PieceComponentTest do
  use ChessTrainerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias ChessTrainerWeb.Board.PieceComponent

  describe "piece_path/1" do
    test "white king" do
      assert PieceComponent.piece_path({:king, :white, :e1}) == "/images/pieces/white/king.svg"
    end

    test "black queen" do
      assert PieceComponent.piece_path({:queen, :black, :d8}) == "/images/pieces/black/queen.svg"
    end

    test "unknown" do
      assert PieceComponent.piece_path({:dragon, :red, :a1}) == nil
    end
  end

  describe "render tests" do
    test "renders a white king image" do
      html =
        render_component(&PieceComponent.piece/1,
          piece: {:king, :white, :e1},
          class: "piece"
        )

      assert html =~ ~s(<img src="/images/pieces/white/king.svg" class="piece")
    end

    test "renders a black pawn image" do
      html =
        render_component(&PieceComponent.piece/1,
          piece: {:pawn, :black, :a7},
          class: "highlight"
        )

      assert html =~ ~s(<img src="/images/pieces/black/pawn.svg" class="highlight")
    end

    test "renders nothing for unknown piece" do
      html =
        render_component(&PieceComponent.piece/1,
          piece: {:dragon, :red, :a1}
        )

      refute html =~ "<img"
    end
  end
end
