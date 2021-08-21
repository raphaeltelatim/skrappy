defmodule Skrappy.Entities.Review do
  alias Skrappy.Entities.Employee

  @moduledoc """
  Stores review attributes in a structed way
  """

  defstruct [:title, :body, :date, :deal_rating, :user, :employees, :fraud_indicator]

  @doc """
  Returns review struct

  ## Example
  iex> Skrappy.Entities.Review.new(attrs)
  %Skrappy.Entities.Review{
    title: "Wow, such title",
    body: "Wow, such body",
    date: "May 17, 2009",
    deal_rating: 5.0,
    user: "G. Fring",
    employees: [
      %Skrappy.Entities.Employee{name: "W. White", rating: 5.0}
    ],
    fraud_indicator: nil
  }
  """
  @spec new(map()) :: struct()
  def new(attrs) do
    %__MODULE__{
      title: attrs.title,
      body: attrs.body,
      date: attrs.date,
      deal_rating: attrs.deal_rating,
      user: attrs.user,
      employees: Enum.map(attrs.employees, &Employee.new/1)
    }
  end
end
