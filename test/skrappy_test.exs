defmodule SkrappyTest do
  use ExUnit.Case
  doctest Skrappy

  test "greets the world" do
    assert Skrappy.hello() == :world
  end
end
