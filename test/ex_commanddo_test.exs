defmodule ExCommanddoTest do
  use ExUnit.Case
  doctest ExCommanddo

  test "greets the world" do
    assert ExCommanddo.hello() == :world
  end
end
