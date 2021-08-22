defmodule Skrappy.Review.Adapter do
  @moduledoc """
  Parses dealerrater html into a map with reviews attributes
  """

  alias Skrappy.Review.Analyzer, as: ReviewAnalyzer

  @doc """
  Returns a map with review information

  ## Example
  iex> from_html(html)
  [
    %{
      body: "Review body",
      date: "June 13, 2021",
      deal_rating: 4.6,
      employees: [
        %{name: "Employee name", rating: 5.0}
      ],
      title: "Review title",
      user: "Review user"
    }
  ]
  """
  def from_html(html) do
    with {:ok, document} <- Floki.parse_document(html) do
      document
      |> Floki.find(".review-entry")
      |> Enum.map(&build_review/1)
    end
  end

  defp build_review(review_html) do
    %{}
    |> Map.put(:title, get_title(review_html))
    |> Map.put(:body, get_body(review_html))
    |> Map.put(:date, get_date(review_html))
    |> Map.put(:deal_rating, get_deal_rating(review_html))
    |> Map.put(:user, get_user(review_html))
    |> Map.put(:employees, get_employees(review_html))
    |> Map.put(:fraud_level, get_fraud_level(review_html))
  end

  defp get_title(review_html) do
    review_html
    |> Floki.find("h3")
    |> Floki.text()
    |> String.replace("\"", "")
  end

  defp get_body(review_html) do
    review_html
    |> Floki.find(".review-content")
    |> Floki.text()
  end

  defp get_date(review_html) do
    review_html
    |> Floki.find(".review-date > :first-child")
    |> Floki.text()
  end

  defp get_deal_rating(review_html) do
    review_html
    |> Floki.find(".dealership-rating > :first-child")
    |> Floki.attribute("class")
    |> deal_rating_from_attributes()
  end

  defp get_user(review_html) do
    review_html
    |> Floki.find(".review-wrapper > :first-child")
    |> Floki.find("span")
    |> Floki.text()
    |> String.replace("- ", "")
    |> String.trim()
  end

  defp get_employees(review_html) do
    review_html
    |> Floki.find(".review-employee")
    |> Enum.map(&build_employee/1)
  end

  defp get_fraud_level(review_html) do
    review_html
    |> get_body()
    |> ReviewAnalyzer.set_fraud_level()
  end

  defp build_employee(employee_html) do
    name =
      employee_html
      |> Floki.find("a")
      |> Floki.text()
      |> String.trim()

    {rating, _} =
      employee_html
      |> Floki.find("span")
      |> Floki.text()
      |> Float.parse()

    %{name: name, rating: rating}
  end

  defp deal_rating_from_attributes([attributes]) do
    {rating, _} =
      attributes
      |> String.replace(~r/[^\d]/, "")
      |> Integer.parse()

    rating / 10.0
  end
end
