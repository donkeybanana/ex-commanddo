defmodule ExCommanddo do
  @moduledoc """
  Documentation for `ExCommanddo`.
  """

  alias ExCommanddo.Task.Echo

  @doc """
  Generate Echo tasks from a range of integers

  ## Examples

      iex> ExCommanddo.tasks_from_range(1..100)
      [%Echo{value: 1, ...}, %Echo{value: 2, ...}, ...]

  """
  def tasks_from_range(range) do
    range
    |> Enum.to_list
    |> Enum.map(fn value ->
      %Echo{value: value}
    end)
  end
end
