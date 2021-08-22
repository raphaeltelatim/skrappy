defmodule Skrappy.Review.AdapterTest do
  use ExUnit.Case, async: true

  alias Skrappy.Review.Adapter, as: ReviewAdapter

  describe "from_html/1" do
    test "parses raw html into review attributes map" do
      assert [
               %{
                 body: "Wow, such a good body",
                 date: "August 18, 2021",
                 deal_rating: 5.0,
                 employees: [
                   %{name: "Taylor Prickett", rating: 5.0},
                   %{name: "Dennis Smith", rating: 5.0},
                   %{name: "Patrick Evans", rating: 5.0},
                   %{name: "Summur Villareal", rating: 5.0}
                 ],
                 title: "Wow, such a good title",
                 user: "Steve W."
               },
               %{
                 body: "Wow, such another good body",
                 date: "August 15, 2021",
                 deal_rating: 4.8,
                 employees: [
                   %{name: "Freddie Tomlinson", rating: 4.7},
                   %{name: "Patrick Evans", rating: 4.9}
                 ],
                 title: "Wow, such another good title",
                 user: "Mark F."
               }
             ] == ReviewAdapter.from_html(raw_html())
    end

    test "returns empty list for invalid html" do
      assert [] == ReviewAdapter.from_html("<html><body><p>Nothing to see here</p></body></html>")
    end
  end

  defp raw_html() do
    "../../support/dealerrater_mock.html"
    |> Path.expand(__DIR__)
    |> File.read!()
  end
end
