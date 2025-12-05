defmodule ChessTrainer.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :name, :string
    field :category, Ecto.Enum, values: [:endgame, :tactic, :opening]

    many_to_many :endgames, ChessTrainer.Endgames.Endgame, join_through: "endgames_tags"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :category])
    |> validate_required([:name, :category])
    |> unique_constraint(:name, name: :tags_name_category_index)
  end
end
