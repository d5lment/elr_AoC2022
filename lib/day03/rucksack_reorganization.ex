defmodule Day03.RucksackReorganization do
  @moduledoc """
  Rucksack Reorganization module have the aim to fix the Elf mistake on AoC day 3 challenge.
  """

  @doc ~S"""
  Follow the rules to reorganize correctly all rucksacks.

  ## Examples
    iex> Day03.RucksackReorganization.reorganize_rucksacks("lib/resources/inputs/day03/contents_rucksack_sample.txt")
    157
  """
  def reorganize_rucksacks(path) do
    path
    |> read_total_items()
    |> Enum.map(fn items_per_rucksack ->
      items_per_rucksack
      |> get_items_per_compartments()
      |> identify_duplicated_item()
    end)
    |> Enum.map(&item_to_priority/1)
    |> Enum.sum()
  end

  @doc ~S"""
  Reads Rucksack total items.
  Generates a list with the lists of items inside each rucksack given a path with the inputs.

  ## Examples
    iex> Day03.RucksackReorganization.read_total_items("/Users/d5lment/workspace/AOC/elr_AoC2022/lib/resources/inputs/day03/contents_rucksack_sample.txt")
    [
      "vJrwpWtwJgWrhcsFMMfFFhFp",
      "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
      "PmmdzqPrVvPwwTWBwg",
      "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
      "ttgJtRGJQctTZtZT",
      "CrZsJsPPZsGzwwsLwLmpwMDw"
    ]
  """
  def read_total_items(path) do
    {:ok, contents} = File.read(path)

    contents
    |> String.split("\n", trim: true)
  end

  @doc """
  1. Get the list of items per each one of two compartments of the rucksack

  ## Examples
    iex> Day03.RucksackReorganization.get_items_per_compartments("vJrwpWtwJgWrhcsFMMfFFhFp")
    ["vJrwpWtwJgWr", "hcsFMMfFFhFp"]
  """
  def get_items_per_compartments(items_per_rucksack) do
    total_items = String.length(items_per_rucksack)
    items_per_compartment = div(total_items, 2)

    items_compartment_1 = String.slice(items_per_rucksack, 0..(items_per_compartment - 1))

    items_compartment_2 =
      String.slice(items_per_rucksack, items_per_compartment..total_items)

    [items_compartment_1, items_compartment_2]
  end

  @doc ~S"""
  2. Identify the duplicated item per rucksack

  ## Examples
    iex> Day03.RucksackReorganization.identify_duplicated_item(["vJrwpWtwJgWr", "hcsFMMfFFhFp"])
    "p"

    iex> Day03.RucksackReorganization.identify_duplicated_item(["jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"])
    "L"

    iex> Day03.RucksackReorganization.identify_duplicated_item(["PmmdzqPrV", "vPwwTWBwg"])
    "P"

    iex> Day03.RucksackReorganization.identify_duplicated_item(["wMqvLMZHhHMvwLH", "jbvcjnnSBnvTQFn"])
    "v"
  """
  def identify_duplicated_item([items_in_1, items_in_2]) do
    Enum.reduce(String.graphemes(items_in_1), fn item, acc ->
      duplicated = if(Enum.member?(String.graphemes(items_in_2), item), do: item)

      case duplicated do
        nil -> acc
        _ -> duplicated
      end
    end)
  end

  @doc ~S"""
  3. Convert duplicated item to priority

  ## Examples
    iex> Day03.RucksackReorganization.item_to_priority("r")
    18
  """
  def item_to_priority(item) do
    Map.get(items_catalog(), item)
  end

  defp items_catalog do
    Enum.into(
      Enum.with_index(for(item <- ?a..?z, do: <<item::utf8>>), 1) ++
        Enum.with_index(for(item <- ?A..?Z, do: <<item::utf8>>), 27),
      %{}
    )
  end
end
