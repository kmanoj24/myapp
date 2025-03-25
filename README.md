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


**Weather API Info
**
The app uses http://api.weatherapi.com/v1/current.json for current weather data.

You can enter either:

A city name (e.g., London, Paris)

A ZIP code (e.g., 10001)

The request is made through Net::HTTP in the ForecastService.

**Caching Details
**
Rails built-in caching (Rails.cache) is used to avoid repeated API calls.

Cache key format: "weather_#{location.parameterize}"

Each result is cached for 30 minutes.

On repeated requests:

If data exists in cache → it does not hit the API

The response will include: cached: true



