defmodule WeitherWeb.HttpTest do
  use ExUnit.Case, async: false
  use Weither.DataCase

  test "api_test" do
    assert :ok = Weither.HttpRequest.request_and_store_weather()
  end
end
