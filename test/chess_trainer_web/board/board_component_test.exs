defmodule ChessTrainerWeb.Board.BoardComponentTest do
  use ChessTrainerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias ChessTrainerWeb.Board.BoardComponent

  #
  # Render tests for the board component
  #
  test "renders board oriented for white" do
    game = %{
      orientation: :white,
      board: %{{:e, 2} => {:pawn, :white, :e2}},
      move_from_square: nil
    }

    html =
      render_component(&BoardComponent.board/1,
        game: game,
        myself: "test-target"
      )

    # ranks should be reversed (8 down to 1)
    assert html =~ ~s(phx-value-rank="8")
    assert html =~ ~s(phx-value-rank="1")

    # files should be a..h in order
    assert html =~ ~s(phx-value-file="a")
    assert html =~ ~s(phx-value-file="h")

    # piece should render
    assert html =~ ~s(<img src="/images/pieces/white/pawn.svg")
  end

  test "renders board oriented for black" do
    game = %{
      orientation: :black,
      board: %{{:e, 7} => {:pawn, :black, :e7}},
      move_from_square: nil
    }

    html =
      render_component(&BoardComponent.board/1,
        game: game,
        myself: "test-target"
      )

    # ranks should be 1..8 in order
    assert html =~ ~s(phx-value-rank="1")
    assert html =~ ~s(phx-value-rank="8")

    # files should be h..a in order
    assert html =~ ~s(phx-value-file="h")
    assert html =~ ~s(phx-value-file="a")

    # piece should render
    assert html =~ ~s(<img src="/images/pieces/black/pawn.svg")
  end

  test "renders highlighted square when move_from_square matches" do
    game = %{
      orientation: :white,
      board: %{},
      move_from_square: {:e, 2}
    }

    html =
      render_component(&BoardComponent.board/1,
        game: game,
        myself: "test-target"
      )

    assert html =~ "ring-yellow-400"
  end
end
