defmodule Puzzle do
  def compute_1(input) do
    input
    |> Enum.map(&String.to_integer(&1))
    |> Enum.sum
  end

  def compute_2(input) do
    input
    |> Enum.map(&String.to_integer(&1)) 
    |> Stream.cycle()
    |> Enum.reduce_while(
      {0, MapSet.new([0])},
      fn x, {current, seen} -> 
        freq = current + x
        case MapSet.member?(seen, freq) do
          true -> {:halt, freq}
          _    -> {:cont, {freq, MapSet.put(seen, freq)}}
        end
      end
    )
  end
end
