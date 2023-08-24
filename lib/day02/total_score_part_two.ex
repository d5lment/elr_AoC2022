defmodule Day02.TotalScorePartTwo do
  @moduledoc """
  Calculates total score from strategy guide provided for the giant Rock Paper Scissors tournament.
  """

  def total_score() do
    "/Users/d5lment/workspace/AOC/elr_AoC2022/lib/resources/inputs/day02/strategy_guide_part_two.txt"
    |> get_guide()
    |> Enum.map(fn inputs ->
      inputs
      |> behaviour()
      |> follow_behaviour()
      |> score()
    end)
    |> Enum.sum()
  end

  def behaviour([oponent, "X"]), do: {:lose, oponent}
  def behaviour([oponent, "Y"]), do: {:draw, oponent}
  def behaviour([oponent, "Z"]), do: {:win, oponent}

  def follow_behaviour({:lose, oponent}) do
    case oponent do
      "A" -> [oponent, "Z"]
      "B" -> [oponent, "X"]
      "C" -> [oponent, "Y"]
    end
  end

  def follow_behaviour({:draw, oponent}) do
    case oponent do
      "A" -> [oponent, "X"]
      "B" -> [oponent, "Y"]
      "C" -> [oponent, "Z"]
    end
  end

  def follow_behaviour({:win, oponent}) do
    case oponent do
      "A" -> [oponent, "Y"]
      "B" -> [oponent, "Z"]
      "C" -> [oponent, "X"]
    end
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
