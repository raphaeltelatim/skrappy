defmodule Skrappy.Review.Analyzer do
  @moduledoc """
  Analyzes a review body and returns the fraud level according to keywords
  found on the review.

  Fraud level is an integer number.

  The higher the number, the more likely the review is a fraud.
  """

  @doc """
  Returns a number that represents the fraud level.

  It uses a highly advanced set of pre determined words to
  set a review fraud level. It also accepts a custom set of
  keywords and level fraud values.

  ## Example
  iex> set_fraud_level("Very nice deal", %{"very" => 1, "nice" => 5})
  6
  """
  @spec set_fraud_level(review_body :: String.t(), keywords :: map()) :: integer()
  def set_fraud_level(review_body, keywords \\ fraud_keywords()) do
    Enum.reduce(keywords, 0, fn {word, fraud_level}, acc ->
      if review_body =~ ~r/#{word}/i do
        acc + fraud_level
      else
        acc
      end
    end)
  end

  defp fraud_keywords() do
    %{
      "awesome" => 60,
      "best" => 90,
      "great" => 40,
      "amazing" => 50,
      "happy" => 50,
      "experience" => 20,
      "exceptional" => 100,
      "recommend" => 60,
      "helped" => 40,
      "nice" => 30
    }
  end
end
