```elixir
"input.txt"
|> File.stream!
|> Stream.map(&String.trim/1)
|> Enum.to_list
|> Puzzle.compute_1
```

should yield: `533`.

```elixir
"input.txt"
|> File.stream!
|> Stream.map(&String.trim/1)
|> Enum.to_list
|> Puzzle.compute_2
```

should yield: `73272`.
