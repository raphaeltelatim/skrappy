defmodule Skrappy.Entities.EmployeeTest do
  use ExUnit.Case

  alias Skrappy.Entities.Employee

  describe "new/1" do
    test "returns an employee struct" do
      attributes = %{name: "J. Pinkman", rating: 4.2}

      assert Employee.new(attributes) == %Employee{name: "J. Pinkman", rating: 4.2}
    end
  end
end
