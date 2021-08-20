defmodule Skrappy.WebClientTest do
  use ExUnit.Case, async: true

  import Mox

  alias Skrappy.Http.Client, as: HttpClient

  @http_client Application.get_env(:skrappy, :http)[:client]

  describe "scrap_page/1" do
    test "returns raw html body on success" do
      expect(@http_client, :get, fn _ ->
        {:ok, %HTTPoison.Response{body: html_response(), status_code: 200}}
      end)

      assert {:ok, success_response} = HttpClient.scrap_page(1)
      assert success_response == html_response()
    end

    test "returns error for an unexisting page" do
      expect(@http_client, :get, fn _ ->
        {:ok, %HTTPoison.Response{status_code: 404}}
      end)

      assert {:error, :not_found} = HttpClient.scrap_page(1)
    end

    test "returns error for any other status than 200" do
      expect(@http_client, :get, fn _ ->
        {:error, %HTTPoison.Error{reason: "Wow, such error :("}}
      end)

      assert {:error, :unexpected} = HttpClient.scrap_page(1)
    end
  end

  defp html_response() do
    "../support/dealerrater_mock.html"
    |> Path.expand(__DIR__)
    |> File.read!()
  end
end
