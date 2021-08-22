defmodule Skrappy.Review.AnalyzerTest do
  use ExUnit.Case, async: true

  alias Skrappy.Review.Analyzer, as: ReviewAnalyzer

  setup do
    keywords = %{"recommend" => 5, "happy" => 10}

    {:ok, %{keywords: keywords}}
  end

  describe "set_fraud_level/2" do
    test "set fraud level given a review and keyword", %{keywords: keywords} do
      review_body = "We are very happy with the deal. Highly recommend it!"

      assert 15 == ReviewAnalyzer.set_fraud_level(review_body, keywords)
    end

    test "keyword search is case insentive", %{keywords: keywords} do
      review_body = "We are very HAPPY with the deal!!!!"

      assert 10 == ReviewAnalyzer.set_fraud_level(review_body, keywords)
    end

    test "fraud_level remains zero if no keyword is found", %{keywords: keywords} do
      assert 0 == ReviewAnalyzer.set_fraud_level("Good deal", keywords)
    end
  end
end
