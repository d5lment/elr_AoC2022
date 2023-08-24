defmodule Day03.RearrangingBadges do
  @moduledoc """
  HOLA
  """

  @doc ~S"""
  Follow the rules to reorganize correctly all rucksacks.

  ## Examples
    iex> Day03.RearrangingBadges.total_items_by_group("/Users/d5lment/workspace/AOC/elr_AoC2022/lib/resources/inputs/day03/contents_rucksack_sample.txt")
    157
  """
  def total_items_by_group(path) do
    {:ok, contents} = File.read(path)

    contents
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
  end
end
