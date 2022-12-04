defmodule Day01.CaloriesCounter do
@moduledoc """
After read and count all the calories by each Elf
identify the Elf carrying the most Calories.
"""

    def read_list_of_calories do
        test_file =
        "/Users/miriam.reyes/workspace/elixir/aoc2022/lib/resources/day01/day_01.txt"

        {:ok, contents} = File.read(test_file)

        contents
        |> String.split("\n\n", trim: true)
        |> Enum.reduce([], fn x, acc ->
            total =
                x
                |> String.split("\n", trim: true)
                |> Enum.map(fn item -> String.to_integer(item) end)
                |> Enum.sum()
            acc ++ [total]
            end)
        |> Enum.max
    end

    def top_three_calories do
        test_file =
        "/Users/miriam.reyes/workspace/elixir/aoc2022/lib/resources/day01/day_01.txt"

        {:ok, contents} = File.read(test_file)
        
        contents
        |> String.split("\n\n", trim: true)
        |> Enum.reduce([], fn x, acc ->
            total =
                x
                |> String.split("\n", trim: true)
                |> Enum.map(fn item -> String.to_integer(item) end)
                |> Enum.sum()
            acc ++ [total]
            end)
        |> Enum.sort
        |> Enum.reverse
        |> Enum.take(3)
        |> Enum.sum
    end
end