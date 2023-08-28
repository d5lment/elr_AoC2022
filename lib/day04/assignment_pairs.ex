defmodule Day04.AssignmentPairs do
  @moduledoc """
  For challenge of day04 we need to answer:
  In how many assignment pairs does one range fully contain the other?

  https://adventofcode.com/2022/day/4
  """

  @doc """

  ## Examples
    iex> Day04.AssignmentPairs.count_overlaps("lib/resources/inputs/day04/assignment_pairs_sample.txt")
    2

    iex> Day04.AssignmentPairs.count_overlaps("lib/resources/inputs/day04/assignment_pairs.txt")
    456
  """
  def count_overlaps(path) do
    path
    |> read_pairs()
    |> Enum.map(&one_secction_fully_contain_other/1)
    |> Enum.sum()
  end

  @doc """

  ## Examples
    iex> Day04.AssignmentPairs.one_secction_fully_contain_other([[2, 4], [6, 8]])
    0

    iex> Day04.AssignmentPairs.one_secction_fully_contain_other([[2, 8], [3, 7]])
    1

    iex> Day04.AssignmentPairs.one_secction_fully_contain_other([[6, 6], [4, 6]])
    1
  """
  def one_secction_fully_contain_other([[x, y], [x1, y1]]) do
    if (x1 >= x and x1 <= y and y1 <= y) or (x >= x1 and x1 <= y1 and y <= y1) do
      1
    else
      0
    end
  end

  @doc ~S"""

  ## Examples
    iex> Day04.AssignmentPairs.read_pairs("lib/resources/inputs/day04/assignment_pairs_sample.txt")
    [
      [[2, 4], [6, 8]],
      [[2, 3], [4, 5]],
      [[5, 7], [7, 9]],
      [[2, 8], [3, 7]],
      [[6, 6], [4, 6]],
      [[2, 6], [4, 8]]
    ]
  """
  def read_pairs(path) do
    {:ok, pairs} = File.read(path)

    pairs
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      x
      |> String.split(",")
      |> Enum.map(fn y ->
        y
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)
      end)
    end)
  end
end
