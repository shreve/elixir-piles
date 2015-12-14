defmodule FizzBuzz do
  @doc """
    Print the sequence up to the nth element
  """
  def print_sequence(n) do
    Enum.each(1..n, fn(i) ->
      IO.puts substitute(i)
    end)
  end

  @doc """
    Replace an integer with it's corresponding value in the Fizz Buzz sequence
  """
  def substitute(n) when rem(n, 5) == 0 and rem(n, 3) == 0, do: "Fizz Buzz"
  def substitute(n) when rem(n, 5) == 0, do: "Buzz"
  def substitute(n) when rem(n, 3) == 0, do: "Fizz"
  def substitute(n), do: n
end
