#!/usr/bin/env elixir

defmodule Munchausen do
  # @cache [0] ++ for n <- 1..9, do: n ** n
  @cache for i <- 1..9, into: %{0 => 0}, do: {i, i ** i}

  def get_cache(), do: @cache

  def explode(n), do: explode(n, [])

  # int, acc -> list[int]
  def explode(n, acc) when n == 0, do: acc

  def explode(n, acc) do
    digit = rem(n, 10)
    explode(div(n, 10), [digit | acc])
  end

  # int -> bool
  def is_munchausen(n) do
    digits = explode(n)
    li = for x <- digits, do: @cache[x]
    n == Enum.sum(li)
  end
end

defmodule Main do
  # @max 10_000
  @max 440_000_000

  def main() do
    # Munchausen.get_cache() |> IO.inspect
    Enum.each(0..@max, fn n ->
      # if rem(n, 1_000_000) == 0 do
        # IO.puts("# #{n}")
      # end
      if Munchausen.is_munchausen(n) do
        IO.puts(n)
      end
    end)
  end
end

Main.main()
