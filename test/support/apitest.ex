defmodule Support.Apitest do
  def get(_url) do
    {:ok,
      %HTTPoison.Response{
        body: 
"{\"lat\":55.7844,\"lon\":38.4448,\"timezone\":\"Europe/Moscow\",\"timezone_offset\":10800,\"current\":{\"dt\":1622998630,\"sunrise\":1622940317,\"sunset\":1623002688,\"temp\":18.66,\"feels_like\":18.98,\"pressure\":1012,\"humidity\":92,\"dew_point\":17.33,\"uvi\":0.11,\"clouds\":100,\"visibility\":10000,\"wind_speed\":1.93,\"wind_deg\":98,\"wind_gust\":5.41,\"weather\":[{\"id\":501,\"main\":\"Rain\",\"description\":\"moderate rain\",\"icon\":\"10d\"}],\"rain\":{\"1h\":1.15}},\"daily\":[{\"dt\":1622970000,\"sunrise\":1622940317,\"sunset\":1623002688,\"moonrise\":1622935920,\"moonset\":1622986440,\"moon_phase\":0.88,\"temp\":{\"day\":21.02,\"min\":10.83,\"max\":21.02,\"night\":15.38,\"eve\":18.11,\"morn\":13.24},\"feels_like\":{\"day\":20.72,\"night\":15.43,\"eve\":18.33,\"morn\":13},\"pressure\":1014,\"humidity\":59,\"dew_point\":12.78,\"wind_speed\":4.39,\"wind_deg\":83,\"wind_gust\":7.26,\"weather\":[{\"id\":502,\"main\":\"Rain\",\"description\":\"heavy intensity rain\",\"icon\":\"10d\"}],\"clouds\":33,\"pop\":1,\"rain\":14.6,\"uvi\":5.69},{\"dt\":1623056400,\"sunrise\":1623026674,\"sunset\":1623089153,\"moonrise\":1623022980,\"moonset\":1623077280,\"moon_phase\":0.91,\"temp\":{\"day\":21.37,\"min\":10.96,\"max\":21.37,\"night\":14.21,\"eve\":19.88,\"morn\":13.05},\"feels_like\":{\"day\":21.1,\"night\":14.17,\"eve\":19.96,\"morn\":12.87},\"pressure\":1012,\"humidity\":59,\"dew_point\":13.08,\"wind_speed\":3.1,\"wind_deg\":78,\"wind_gust\":5.47,\"weather\":[{\"id\":501,\"main\":\"Rain\",\"description\":\"moderate rain\",\"icon\":\"10d\"}],\"clouds\":33,\"pop\":1,\"rain\":6.87,\"uvi\":5.75},{\"dt\":1623142800,\"sunrise\":1623113034,\"sunset\":1623175614,\"moonrise\":1623110100,\"moonset\":1623168180,\"moon_phase\":0.94,\"temp\":{\"day\":21.93,\"min\":13,\"max\":21.93,\"night\":14.37,\"eve\":18.16,\"morn\":14.54},\"feels_like\":{\"day\":21.85,\"night\":14.4,\"eve\":18.33,\"morn\":14.53},\"pressure\":1011,\"humidity\":64,\"dew_point\":14.86,\"wind_speed\":4.12,\"wind_deg\":66,\"wind_gust\":7.87,\"weather\":[{\"id\":501,\"main\":\"Rain\",\"description\":\"moderate rain\",\"icon\":\"10d\"}],\"clouds\":98,\"pop\":1,\"rain\":9.84,\"uvi\":5.85},{\"dt\":1623229200,\"sunrise\":1623199398,\"sunset\":1623262073,\"moonrise\":1623197460,\"moonset\":1623258960,\"moon_phase\":0.97,\"temp\":{\"day\":17.31,\"min\":12.81,\"max\":17.39,\"night\":15.29,\"eve\":16.97,\"morn\":14.14},\"feels_like\":{\"day\":17.34,\"night\":15.22,\"eve\":16.94,\"morn\":14.14},\"pressure\":1012,\"humidity\":86,\"dew_point\":14.93,\"wind_speed\":4.31,\"wind_deg\":66,\"wind_gust\":8.76,\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":100,\"pop\":0.37,\"rain\":0.58,\"uvi\":2.66},{\"dt\":1623315600,\"sunrise\":1623285765,\"sunset\":1623348528,\"moonrise\":1623285180,\"moonset\":1623349620,\"moon_phase\":0,\"temp\":{\"day\":19.58,\"min\":13.71,\"max\":20.03,\"night\":15.68,\"eve\":20.03,\"morn\":13.78},\"feels_like\":{\"day\":19.29,\"night\":15.55,\"eve\":19.81,\"morn\":13.54},\"pressure\":1012,\"humidity\":65,\"dew_point\":12.93,\"wind_speed\":4.33,\"wind_deg\":51,\"wind_gust\":8.25,\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":89,\"pop\":0.2,\"rain\":0.14,\"uvi\":2.13},{\"dt\":1623402000,\"sunrise\":1623372137,\"sunset\":1623434979,\"moonrise\":1623373380,\"moonset\":1623439740,\"moon_phase\":0.03,\"temp\":{\"day\":23.59,\"min\":11.74,\"max\":24.27,\"night\":16.42,\"eve\":22.73,\"morn\":14.37},\"feels_like\":{\"day\":22.92,\"night\":16,\"eve\":22.21,\"morn\":13.95},\"pressure\":1014,\"humidity\":35,\"dew_point\":7.46,\"wind_speed\":5.49,\"wind_deg\":52,\"wind_gust\":9.24,\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":0,\"pop\":0,\"uvi\":3},{\"dt\":1623488400,\"sunrise\":1623458512,\"sunset\":1623521427,\"moonrise\":1623462360,\"moonset\":1623529140,\"moon_phase\":0.06,\"temp\":{\"day\":25.41,\"min\":12.41,\"max\":26.12,\"night\":17.61,\"eve\":24.16,\"morn\":14.88},\"feels_like\":{\"day\":24.84,\"night\":17.15,\"eve\":23.73,\"morn\":14.33},\"pressure\":1017,\"humidity\":32,\"dew_point\":7.5,\"wind_speed\":3.61,\"wind_deg\":66,\"wind_gust\":6.51,\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":0,\"pop\":0,\"uvi\":3},{\"dt\":1623574800,\"sunrise\":1623458512,\"sunset\":1623521427,\"moonrise\":1623462360,\"moonset\":1623529140,\"moon_phase\":0.06,\"temp\":{\"day\":21.11,\"min\":10.49,\"max\":28.16,\"night\":16.67,\"eve\":23.13,\"morn\":14.81},\"feels_like\":{\"day\":24.84,\"night\":17.15,\"eve\":23.73,\"morn\":14.33},\"pressure\":1017,\"humidity\":32,\"dew_point\":7.5,\"wind_speed\":3.61,\"wind_deg\":66,\"wind_gust\":6.51,\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":0,\"pop\":0,\"uvi\":3}]}",
        headers: [
          {"Server", "openresty"},
          {"Date", "Sun, 06 Jun 2021 16:57:10 GMT"},
          {"Content-Type", "application/json; charset=utf-8"},
          {"Content-Length", "4280"},
          {"Connection", "keep-alive"},
          {"X-Cache-Key",
           "/data/2.5/onecall?exclude=alerts,hourly,minutely&lat=55.78&lon=38.44&units=metric"},
          {"Access-Control-Allow-Origin", "*"},
          {"Access-Control-Allow-Credentials", "true"},
          {"Access-Control-Allow-Methods", "GET, POST"}
        ],
        request: %HTTPoison.Request{
          body: "",
          headers: [],
          method: :get,
          options: [],
          params: %{},
          url: "https://api.openweathermap.org/data/2.5/onecall?lat=55.784445&lon=38.444849&exclude=alerts,hourly,minutely&units=metric"
        },
        request_url: "https://api.openweathermap.org/data/2.5/onecall?lat=55.784445&lon=38.444849&exclude=alerts,hourly,minutely&units=metric",
        status_code: 200
      }
    }
  end
end
