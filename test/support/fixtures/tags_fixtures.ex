defmodule ChessTrainer.TagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChessTrainer.Tags` context.
  """

  @doc """
  Generate a unique tag name.
  """
  def unique_tag_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        category: "some category",
        name: unique_tag_name()
      })
      |> ChessTrainer.Tags.create_tag()

    tag
  end
end
