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
        fen: "some fen",
        key: "some key",
        message: "some message",
        notes: "some notes",
        result: :draw
      })
      |> ChessTrainer.Endgames.create_endgame()

    endgame
  end
end
