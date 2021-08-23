defmodule Skrappy.Factory do
  @moduledoc """
  Factory for tests purposes

  https://hexdocs.pm/ecto/test-factories.html
  """

  alias Skrappy.Entities.{Employee, Review}

  def build(:employee) do
    %Employee{
      name: "Nacho V.",
      rating: 4.8
    }
  end

  def build(:review) do
    %Review{
      title: "Wow, such title",
      body: "Wow, such body",
      date: "May 17, 2009",
      deal_rating: 5.0,
      user: "Gustavo F.",
      employees: [build(:employee)],
      fraud_level: 2
    }
  end

  def build(factory_name, attributes) do
    factory_name
    |> build()
    |> struct!(attributes)
  end

  def reviews_html() do
    "dealerrater_mock.html"
    |> Path.expand(__DIR__)
    |> File.read!()
  end
end
