defmodule ChessTrainer.Endgames.Endgame do
  @moduledoc """
  A singular endgame entry
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "endgames" do
    field :fen, :string
    field :key, :string
    field :message, :string
    field :notes, :string
    field :result, Ecto.Enum, values: [:win, :loss, :draw]
    field :rating, :integer
    field :rating_deviation, :integer
    field :times_attempted, :integer
    field :times_solved, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(endgame, attrs) do
    endgame
    |> cast(attrs, [:fen, :key, :message, :notes, :result, :rating])
    |> validate_required([:fen, :key, :result, :rating])
    |> unique_constraint(:fen, message: "FEN already exists")
  end
end
