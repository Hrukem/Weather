def take_weather_from_websait() do
  with {:ok, answer_map} <- HTTPoison.get @request <> Application.get_env(:weither, :secret_weather_api)
       true              <- answer_map.status_code == 200
       {:ok, weather}    <- body.decode(answer_map.body) do
    weather
  else
    {:error, HTTPoison.Error{}} ->
      {:error, :httpPoison_error}
    false ->
      {:error, answer_map.status_code}
    {:error, :bad_body} ->
      {:error, :bad_body}
  end
end
