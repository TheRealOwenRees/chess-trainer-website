defmodule ChessTrainer.Game do
  @moduledoc """
  Game related functions
  """
  alias ChessTrainer.Endgames

  @type game_type :: :endgame
  @type square :: {atom(), pos_integer()}
  @type move :: {square, square}
  @type colors :: :white | :black
  @type game_state :: :continue | :loss | :draw

  @type t :: %__MODULE__{
          player_color: colors,
          board: map(),
          active_color: colors,
          castling: list(),
          en_passant: term() | nil,
          moves: list(),
          halfmove_clock: non_neg_integer(),
          fullmove_clock: non_neg_integer(),
          captures: list(),
          check: term() | nil,
          result: term() | nil,
          pgn: String.t() | nil,
          orientation: colors,
          move_from_square: square,
          move_to_square: square,
          game_type: game_type,
          fen: String.t(),
          tablebase: term(),
          game_state: game_state
        }

  defstruct board: %{},
            player_color: :white,
            active_color: :white,
            castling: [],
            en_passant: nil,
            moves: [],
            halfmove_clock: 0,
            fullmove_clock: 0,
            captures: [],
            check: nil,
            result: nil,
            pgn: nil,
            orientation: :white,
            move_from_square: nil,
            move_to_square: nil,
            game_type: nil,
            fen: nil,
            tablebase: nil,
            game_state: :continue

  @spec game_from_fen(String.t(), game_type()) :: {:ok, t()} | {:error, atom()}
  def game_from_fen(fen, game_type) do
    try do
      {:ok, %Chex.Game{} = chex_game} = Chex.Parser.FEN.parse(fen)

      game = %__MODULE__{
        board: chex_game.board,
        player_color: chex_game.active_color,
        active_color: chex_game.active_color,
        castling: chex_game.castling,
        en_passant: chex_game.en_passant,
        moves: chex_game.moves,
        halfmove_clock: chex_game.halfmove_clock,
        fullmove_clock: chex_game.fullmove_clock,
        captures: chex_game.captures,
        check: chex_game.check,
        result: chex_game.result,
        pgn: chex_game.pgn,
        orientation: chex_game.active_color,
        move_from_square: nil,
        move_to_square: nil,
        game_type: game_type,
        fen: fen,
        game_state: :continue,
        tablebase:
          if game_type === :endgame do
            Endgames.Tablebase.new(fen)
          else
            nil
          end
      }

      {:ok, game}
    rescue
      MatchError -> {:error, :invalid_fen}
    end
  end
end
