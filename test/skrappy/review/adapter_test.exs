defmodule Skrappy.Review.AdapterTest do
  use ExUnit.Case, async: true

  alias Skrappy.Review.Adapter, as: ReviewAdapter

  import Skrappy.Factory

  describe "from_html/1" do
    test "parses raw html into review attributes map" do
      assert [
               %{
                 body: "Wow, such exceptional body",
                 date: "August 18, 2021",
                 deal_rating: 5.0,
                 employees: [
                   %{name: "Taylor Prickett", rating: 5.0},
                   %{name: "Dennis Smith", rating: 5.0},
                   %{name: "Patrick Evans", rating: 5.0},
                   %{name: "Summur Villareal", rating: 5.0}
                 ],
                 title: "Wow, such a good title",
                 user: "Steve W.",
                 fraud_level: 100
               },
               %{
                 body: "Wow, such awesome body",
                 date: "August 15, 2021",
                 deal_rating: 4.8,
                 employees: [
                   %{name: "Freddie Tomlinson", rating: 4.7},
                   %{name: "Patrick Evans", rating: 4.9}
                 ],
                 title: "Wow, such title",
                 user: "Mark F.",
                 fraud_level: 60
               }
             ] == ReviewAdapter.from_html(reviews_html())
    end

    test "returns empty list for invalid html" do
      assert [] == ReviewAdapter.from_html("<html><body><p>Nothing to see here</p></body></html>")
    end
  end
end
