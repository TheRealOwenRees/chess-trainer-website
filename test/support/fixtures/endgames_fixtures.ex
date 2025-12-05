defmodule ChessTrainer.EndgamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChessTrainer.Endgames` context.
  """

  @doc """
  Generate a endgame.
  """
  def endgame_fixture(attrs \\ %{}) do
    {:ok, endgame} =
      attrs
      |> Enum.into(%{
        fen: "6k1/5p2/6p1/8/7p/8/6PP/6K1 b - - 0 0",
        key: "some key",
        message: "some message",
        notes: "some notes",
        result: :draw,
        rating: 1500,
        color: :black,
        rating_deviation: 350,
        times_attempted: 0,
        times_solved: 0
      })
      |> ChessTrainer.Endgames.create_endgame()

    endgame
  end
end
