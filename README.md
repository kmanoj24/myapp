# MyApp

This is a sample Rails weather forecast app using WeatherAPI.

## How to Run Locally

bundle install

rails db:create db:migrate

rails s

# Weather Forecast App (Ruby on Rails)
How to Use
Start your Rails server:

rails s
Open your browser and visit:

http://localhost:3000
Enter a valid location name (e.g., London, Paris) or ZIP code (e.g., 10001) in the search field.

Click Submit to see the weather forecast.

If the same location was searched in the last 30 minutes:

The app pulls the result from cache

A message is shown: ✅ Result pulled from cache

Example Input:
London

10001

New York

🔁 Cache will auto-expire after 30 minutes and fetch fresh data again.
