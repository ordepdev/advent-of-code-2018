defmodule Puzzle do
  def compute_1(input) do
    input
    |> Enum.map(&String.graphemes(&1))
    |> Enum.map(&(parse(&1)))
    |> calc
  end


  defp calc(input) do
    occurrences(input, 2) * occurrences(input, 3)
  end

  defp occurrences(input, value) do
    input
    |> Enum.filter(&(Enum.any?(&1, fn x -> x == value end)))
    |> Enum.count
  end

  defp parse(input) do
    input
    |> Enum.group_by(&(&1))
    |> Map.values()
    |> Enum.map(&(Enum.count(&1)))
  end

  def compute_2(input) do
    input
    |> calc_2
  end

  def calc_2([head | tail]) do
    tail
    |> Enum.map(
      &String.myers_difference(&1, head)
      |> Keyword.get_values(:eq)
      |> Enum.join("")
    )
    |> Enum.find(&(String.length(&1) == 25))
    |> case do
      nil -> calc_2(tail)
      result -> result
    end
  end
end
