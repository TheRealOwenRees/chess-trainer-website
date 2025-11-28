defmodule ChessTrainerWeb.BoardLiveComponent do
  @moduledoc """
  Chess board LiveView component
  """
  use Phoenix.LiveComponent
  import ChessTrainerWeb.Board.BoardComponent
  # alias ChessTrainer.Chess.Game

  def render(assigns) do
    ~H"""
    <.board game={@game} myself={@myself} />
    """
  end
end
