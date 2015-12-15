defmodule Geometry do
  @pi 3.1415926535

  @doc """
    Return the surface area of a shape given some dimensions
  """
  def area(details) do
    case details do
      {:circle, radius} -> radius * @pi

      {:sphere, radius} -> 4 * @pi * :math.pow(radius, 2)

      {:square, length} -> :math.pow(length, 2)
      {:square, length, width} -> length * width

      {:cube, length} -> 6 * :math.pow(length, 2)
      {:cube, length, width, height} ->
        (4 * area({:square, length, width})) +
        (2 * area({:square, length, height}))

      {:triangle, base, height} -> (1/2) * base * height
    end
  end

  @doc """
    Return the volume of a shape given some dimensions
  """
  def volume(details) do
    case details do
      {:sphere, radius} -> (4/3) * @pi * :math.pow(radius, 3)

      {:cube, length} -> :math.pow(length, 3)
      {:cube, length, width, height} -> length * width * height
    end
  end
end
