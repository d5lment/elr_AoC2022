defmodule Day03.RearrangingBadges do
  @moduledoc """
  HOLA
  """

  alias Day03.RucksackReorganization, as: Tools

  @doc ~S"""
  Creates a list of three MapSets with the unique types per rucksack in order to enable set operations.
  ## Examples
    iex> Day03.RearrangingBadges.rearranging_badges("lib/resources/inputs/day03/contents_rucksack_sample.txt")
    70
  """
  def rearranging_badges(path) do
    path
    |> total_items_by_group()
    |> Enum.map(&prepare_intersection/1)
    |> Enum.map(&getting_badget/1)
    |> Enum.map(&Tools.item_to_priority/1)
    |> Enum.sum()
  end

  @doc ~S"""
  Returns only the type that each Rucksack in the group (of three) have in common.
  ## Examples
    iex> Day03.RearrangingBadges.getting_badget([MapSet.new(["F", "J", "M", "W", "c", "f", "g", "h", "p", "r", "s", "t", "v","w"]), MapSet.new(["D", "F", "G", "H", "L", "M", "N", "R", "S", "Z", "f", "j", "q","r", "s", "z"]), MapSet.new(["B", "P", "T", "V", "W", "d", "g", "m", "q", "r", "v", "w", "z"])])
    "r"
  """
  def getting_badget([rucksack1, rucksack2, rucksack3]) do
    [badget] =
      rucksack1
      |> MapSet.intersection(rucksack2)
      |> MapSet.intersection(rucksack3)
      |> MapSet.to_list()

    badget
  end

  @doc ~S"""
  Creates a list of three MapSets with the unique types per rucksack in order to enable MapSet operations.
  ## Examples
    iex> Day03.RearrangingBadges.prepare_intersection(["vJrwpWtwJgWrhcsFMMfFFhFp","jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL","PmmdzqPrVvPwwTWBwg"])
    [
      MapSet.new(["F", "J", "M", "W", "c", "f", "g", "h", "p", "r", "s", "t", "v","w"]),
      MapSet.new(["D", "F", "G", "H", "L", "M", "N", "R", "S", "Z", "f", "j", "q","r", "s", "z"]),
      MapSet.new(["B", "P", "T", "V", "W", "d", "g", "m", "q", "r", "v", "w", "z"])
    ]
  """
  def prepare_intersection(items_by_group) do
    Enum.map(items_by_group, fn items_per_rucksack ->
      items_per_rucksack
      |> String.graphemes()
      |> Enum.uniq()
      |> MapSet.new()
    end)
  end

  @doc ~S"""
  Creates groups of three rucksacks from the input.

  ## Examples
    iex> Day03.RearrangingBadges.total_items_by_group("lib/resources/inputs/day03/contents_rucksack_sample.txt")
    [
      ["vJrwpWtwJgWrhcsFMMfFFhFp",
      "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
      "PmmdzqPrVvPwwTWBwg"],
      ["wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
      "ttgJtRGJQctTZtZT",
      "CrZsJsPPZsGzwwsLwLmpwMDw"]
    ]
  """
  def total_items_by_group(path) do
    {:ok, contents} = File.read(path)

    contents
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
  end
end
