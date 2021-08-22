defmodule Skrappy.Entities.ReviewTest do
  use ExUnit.Case

  alias Skrappy.Entities.Review
  alias Skrappy.Entities.Employee

  describe "new/1" do
    test "returns a review struct" do
      attributes = %{
        title: "Wow, such title",
        body: "Wow, such body",
        date: "May 17, 2009",
        deal_rating: 5.0,
        user: "G. Fring",
        employees: [%{name: "W. White", rating: 5.0}],
        fraud_level: 143
      }

      assert Review.new(attributes) == %Skrappy.Entities.Review{
               title: "Wow, such title",
               body: "Wow, such body",
               date: "May 17, 2009",
               deal_rating: 5.0,
               user: "G. Fring",
               employees: [
                 %Skrappy.Entities.Employee{name: "W. White", rating: 5.0}
               ],
               fraud_level: 143
             }
    end
  end
end
