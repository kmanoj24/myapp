# MyApp

This is a sample Rails weather forecast app using WeatherAPI.

## 🚀 How to Run Locally

bundle install
rails db:create db:migrate
rails s

# Weather Forecast App (Ruby on Rails)

This is a simple Ruby on Rails application that allows users to input an address (or ZIP code) and retrieve weather forecast data, including the current temperature, high/low, and cache functionality.

---

## 🚀 Features

- Accept address input from user
- Fetch weather data using WeatherAPI (current temp, high/low, etc.)
- Caches results for 30 minutes per ZIP code
- Displays cache status to user
- Clean MVC structure with service objects
- Unit tested with RSpec

