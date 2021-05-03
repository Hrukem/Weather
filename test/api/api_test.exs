defmodule Api.ApiTest do
  use ExUnit.Case

  test "get history" do
    res = Weither.Api.get(:history, 4) 
    res_error = Weither.Api.get(:history, 8) 

    assert String.to_float(res) |> is_float()
    assert res_error == "Error. num в запросе должно быть меньше или равно 5"
  end

  test "get forecast" do
    res = Weither.Api.get(:forecast, 4) 
    res_error = Weither.Api.get(:forecast, 8) 

    assert String.contains?(res, ["day=", "night="])
    assert res_error == "Error. num в запросе должно быть меньше или равно 7"
  end
end
