defmodule Puzzle do
  def compute_1(input) do
    input
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse(&1))
    |> overlaped
  end
  def compute_2(input) do
    input
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse(&1))
    |> not_overlaped
  end

  defp parse(input) do
    input
    |> String.split(["#", " @ ", ",", ": ", "x"], trim: true)
    |> Enum.map(&String.to_integer(&1))
  end

  # map = ...
  # for x ...
  #   for y ...
  #     map.put {x, y} id
  def claimed_area(claims) do
    Enum.reduce(claims, %{}, fn claim, acc ->
      [id, left, top, width, height] = claim
      Enum.reduce((left + 1)..(left + width), acc, fn x, acc ->
        Enum.reduce((top + 1)..(top + height), acc, fn y, acc ->
          Map.update(acc, {x, y}, [id], &[id | &1])
        end)
      end)
    end)
  end

  def overlaped(claims) do
    claims
    |> claimed_area
    |> Enum.count(fn {_k, v} -> length(v) >= 2 end)
  end

  def not_overlaped(input) do
    claimed_area = claimed_area(input)

    claimed_area_ids =
      claimed_area
      |> Enum.flat_map(fn {_k, v} -> v end)
      |> Enum.uniq

    overlaped_claimed_area_ids =
      claimed_area
      |> Enum.filter(fn {_k, v} -> length(v) >= 2 end)
      |> Enum.flat_map(fn {_k, v} -> v end)
      |> Enum.uniq

    claimed_area_ids
    |> Enum.filter(&(&1 not in overlaped_claimed_area_ids))
  end
end
