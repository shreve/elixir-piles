defmodule Matrix do

  @doc """
    Multiply a matrix, A, by a vector, x, to return a new vector, b.

    In terms of types, the matrix is a list of lists of numbers, while the
    vector is just a list of numbers.
    The width of the matrix needs to equal the height of the vector.
  """
  def multiply(a, x) do
    x = List.to_tuple(x)
    # For each row,
    Enum.map(a, fn(row) ->
      # ensure the multiplication can be done
      if length(row) != tuple_size(x) do
        raise "Matrix size mismatch: A's width doesn't equal x's height"
      end

      # and for each element in that row,
      Enum.reduce(Enum.with_index(row), 0, fn(el, acc) ->
        # Multiply the element by it's corresponding value in x
        (elem(el, 0) * elem(x, elem(el, 1))) + acc
      end)
    end)
  end

  @doc """
    Create an n-dimensional identity matrix.
  """
  def identity(n) do
    # From 1 to n,
    Enum.map((1..n), fn(x) ->
      List.replace_at(
        # create a row of length n filled with 0s
        Enum.map((1..n), fn(_) -> 0 end),
        # and replace the diagonal entry in that row with 1.
        x - 1, 1)
    end)
  end

  @doc """
    Append the provided vector, b, to the right side of the matrix, A.

    The matrix and vector must be the same height.
  """
  def augment(a, b) do
    if length(a) != length(b) do
      raise "Matrix size mismatch: A and b must be the same height."
    end
    b = List.to_tuple(b)
    Enum.map(Enum.with_index(a), fn(row) ->
      List.insert_at(elem(row, 0), -1, elem(b, elem(row, 1)))
    end)
  end

end
