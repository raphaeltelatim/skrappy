defmodule SkrappyTest do
  use ExUnit.Case

  import Mox
  import Skrappy.Factory

  @http_client Application.compile_env(:skrappy, :http)[:client]

  describe "fraud_detect/1" do
    test "returns the 3 most likely fraud reviews ranked" do
      expect(@http_client, :get, fn _ ->
        {:ok, %HTTPoison.Response{body: reviews_html(), status_code: 200}}
      end)

      assert [
        %Skrappy.Entities.Review{
          body: "Wow, such exceptional body",
          date: "August 18, 2021",
          deal_rating: 5.0,
          employees: [
            %Skrappy.Entities.Employee{name: "Taylor Prickett", rating: 5.0},
            %Skrappy.Entities.Employee{name: "Dennis Smith", rating: 5.0},
            %Skrappy.Entities.Employee{name: "Patrick Evans", rating: 5.0},
            %Skrappy.Entities.Employee{name: "Summur Villareal", rating: 5.0}
          ],
          fraud_level: 100,
          title: "Wow, such a good title",
          user: "Steve W."
        },
        %Skrappy.Entities.Review{
          body: "Wow, such awesome body",
          date: "August 15, 2021",
          deal_rating: 4.8,
          employees: [
            %Skrappy.Entities.Employee{name: "Freddie Tomlinson", rating: 4.7},
            %Skrappy.Entities.Employee{name: "Patrick Evans", rating: 4.9}
          ],
          fraud_level: 60,
          title: "Wow, such title",
          user: "Mark F."
        }
      ] == Skrappy.fraud_detect(1)
    end
  end
end
