defmodule Skrappy.Http.Client do
  @moduledoc """
    Provides a way to scrap a web page
  """

  @doc """
  Returns a raw html for the given page number

  ## Example
  iex> scrap_page(1)
  {:ok, "<body>\n Hi, I'm a HTML body\n</body>\n"}
  """
  @spec scrap_page(page :: integer()) :: {:ok, String.t()} | {:error, term()}
  def scrap_page(page) do
    page
    |> get_page()
    |> handle_response()
  end

  defp get_page(page) do
    url = base_url() <> "page#{page}"

    http_client().get(url)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 404}}) do
    {:error, :not_found}
  end

  defp handle_response(_) do
    {:error, :unexpected}
  end

  defp base_url(), do: Application.get_env(:skrappy, :http)[:base_url]

  defp http_client(), do: Application.get_env(:skrappy, :http)[:client]
end
