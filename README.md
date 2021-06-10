# Weither

The site shows the weather in Elektrostal. You can view the weather history or the forecast for 7 days.  
The weather history is saved in 3-hour increments (00:00, 00:03, 00:04, ... , 18:00, 21:00). UTC time.  
Data output is limited to 60 values.  
The weather forecast is displayed for one day, which is separated from the current date by the specified number of days.  
You can get the data on the site pages or by sending a request through the search bar.  

Format of the forecast request:  
 >namesite/weather?type=history&num=YYYY-MM-DD_hh:mm:ss,YYYY-MM-DD_hh:mm:ss  

Format of the forecast request:  
 >namesite/weather?type=forecast&num=n  

where  
- namesite is the site name (for example, weather.hrukem.xyz)  
- YYYY is the year, MM is the month, DD is the day of the week, hh is the hours, mm is the minutes, ss is the seconds  
- n is the day from today to show the forecast  
Important: months, days, hours, minutes, seconds must be specified in 2 digits. If the second month is (February),
then enter 02, etc.  
Also, the first date must be earlier than the second, otherwise the request will not be accepted.

Для запуска сайта на локальном компьютере:  
- скопируйте сайт с git репозитория на свой компьютер
- запустите команду mix deps.get
- запустите команды mix ecto.create; mix ecto.migrate
- создайте в корневой папке (там, где расположен файл mix.exs) файл .env
Данный файл должен содержать следующие строки:
>PORT=xxxx  
>SECRET_KEY_BASE=yyyy  
>SECRET_WEATHER_API=zzzz  

где хххх - номер порта на котором будет работать приложение  
yyyy - секретный ключ, его лучше сгенерировать с помощью команды mix gen.secret  
zzzz - api-key, полученный при регистрации на сайте www.openweathermap.org  
строки вводятся без кавычек 
