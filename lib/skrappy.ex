defmodule Skrappy do
  @moduledoc """
  Scrapes N (default 5) pages from www.dealerrater.com and
  returns the 3 most likely fraudulent reviews based
  on a pre determined list of suspicious words.
  """

  alias Skrappy.Entities.Review
  alias Skrappy.Http.Client, as: HttpClient
  alias Skrappy.Review.Adapter, as: ReviewAdapter
  alias Skrappy.Review.Analyzer, as: ReviewAnalyzer

  @spec fraud_detect(max_pages :: integer()) :: list(struct)
  def fraud_detect(max_pages \\ 5) do
    1..max_pages
    |> Enum.map(&HttpClient.scrap_page/1)
    |> Enum.reduce([], fn {status, html}, acc ->
      if status == :ok, do: [html | acc]
    end)
    |> Enum.flat_map(&ReviewAdapter.from_html/1)
    |> Enum.map(&Review.new/1)
    |> ReviewAnalyzer.most_suspicious(3)
  end
end
