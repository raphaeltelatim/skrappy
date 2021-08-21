defmodule Skrappy.Entities.Employee do
  @moduledoc """
  Stores employee attributes in a structed way
  """

  defstruct [:name, :rating]

  @doc """
  Returns employee struct

  ## Examples

    iex> Skrappy.Entities.Employee.new(attrs)
    %Skrappy.Entities.Employee{
      name: "J. Pinkman",
      rating: 4.2
    }
  """
  @spec new(map()) :: struct()
  def new(attrs) do
    %__MODULE__{
      name: attrs.name,
      rating: attrs.rating
    }
  end
end
