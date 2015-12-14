defmodule Fibonacci do
  @doc """
    Return the nth number of the fibonacci sequence
  """
  def num(n) do
    # Only take the first element from the tuple returned by num/2
    elem(num(n, %{}), 0)
  end

  @doc """
    Print the fibonacci sequence up to the specified digit
  """
  def print_sequence(n) do
    Enum.each(0..n, fn (i) ->
      IO.puts "#{i}: #{Fibonacci.num(i)}"
    end)
  end

  # num/2 returns { number, cache }
  defp num(0, cache), do: { 1, cache }
  defp num(1, cache), do: { 1, cache }
  defp num(n, cache) do
    if Dict.has_key?(cache, n) do
      { cache[n], cache }
    else
      { n1, n1cache } = num(n - 1, cache)
      { n2, n2cache } = num(n - 2, n1cache)
      { n1 + n2, Dict.put(n2cache, n, n1 + n2) }
    end
  end
end

