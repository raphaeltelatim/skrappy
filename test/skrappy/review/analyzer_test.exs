defmodule Skrappy.Review.AnalyzerTest do
  use ExUnit.Case, async: true

  alias Skrappy.Review.Analyzer, as: ReviewAnalyzer

  import Skrappy.Factory

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

  describe "most_suspicious/1" do
    test "returns most n suspicious reviews" do
      review_1 = build(:review, fraud_level: 100)
      review_2 = build(:review, fraud_level: 50)
      review_3 = build(:review, fraud_level: 27)

      assert [review_1, review_2] ==
               ReviewAnalyzer.most_suspicious([review_1, review_2, review_3], 2)
    end
  end
end
