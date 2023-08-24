defmodule Day02.TotalScore do
  @moduledoc """
  Calculates total score from strategy guide provided for the giant Rock Paper Scissors tournament.
  """

  def total_score_part_one() do
    "/Users/d5lment/workspace/AOC/elr_AoC2022/lib/resources/inputs/day02/strategy_guide.txt"
    |> get_guide()
    |> Enum.map(fn inputs -> score(inputs) end)
    |> Enum.sum()
  end

  def score(inputs) do
    shape_score = get_shape_score(inputs)

    outcome_score =
      case get_outcome(inputs) do
        :lost -> 0
        :draw -> 3
        :win -> 6
      end

    shape_score + outcome_score
  end

  def get_guide(file) do
    {:ok, contents} = File.read(file)

    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      String.split(x, " ")
    end)
  end

  def get_outcome(["A", "X"]), do: :draw
  def get_outcome(["B", "X"]), do: :lost
  def get_outcome(["C", "X"]), do: :win
  def get_outcome(["A", "Y"]), do: :win
  def get_outcome(["B", "Y"]), do: :draw
  def get_outcome(["C", "Y"]), do: :lost
  def get_outcome(["A", "Z"]), do: :lost
  def get_outcome(["B", "Z"]), do: :win
  def get_outcome(["C", "Z"]), do: :draw

  def get_shape_score([_, "X"]), do: 1
  def get_shape_score([_, "Y"]), do: 2
  def get_shape_score([_, "Z"]), do: 3
end
