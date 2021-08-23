defmodule Skrappy.Http.ClientTest do
  use ExUnit.Case, async: true

  import Mox
  import Skrappy.Factory

  alias Skrappy.Http.Client, as: HttpClient

  @http_client Application.compile_env(:skrappy, :http)[:client]

  describe "scrap_page/1" do
    test "returns raw html body on success" do
      expect(@http_client, :get, fn _ ->
        {:ok, %HTTPoison.Response{body: reviews_html(), status_code: 200}}
      end)

      assert {:ok, success_response} = HttpClient.scrap_page(1)
      assert success_response == reviews_html()
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
end
