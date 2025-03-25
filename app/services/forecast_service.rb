require 'net/http'
require 'uri'
require 'json'

class ForecastService
  API_KEY = ENV['WEATHER_API_KEY']
  BASE_URL = "http://api.weatherapi.com/v1/current.json"

  def self.fetch(address)
    Rails.logger.info "Called with address: #{address}"

    # Normalize the input (to avoid cache key mismatches)
    normalized = address.to_s.strip.downcase
    cache_key = "weather_#{normalized.parameterize}"
    Rails.logger.info "Normalized Cache Key: #{cache_key}"

    # Check if cached data exists
    data = Rails.cache.read(cache_key)
    if data
      Rails.logger.info "Loaded from cache: #{cache_key}"
      data[:cached] = true
      return data
    end

    # No cache – hit the API
    url = "#{BASE_URL}?key=#{API_KEY}&q=#{URI.encode_www_form_component(address)}"
    Rails.logger.info "API URL: #{url}"

    response = Net::HTTP.get_response(URI(url))
    Rails.logger.info "Response Code: #{response.code}"

    return nil unless response.is_a?(Net::HTTPSuccess)

    json = JSON.parse(response.body)
    return nil if json["error"]

    current_temp   = json.dig("current", "temp_c")
    condition_text = json.dig("current", "condition", "text")
    icon_url       = json.dig("current", "condition", "icon")
    location_name  = json.dig("location", "name")
    updated_time   = json.dig("current", "last_updated")

    return nil if current_temp.nil?

    # Prepare response
    data = {
      location: location_name,
      current_temp: current_temp,
      condition: condition_text,
      icon: icon_url,
      updated_at: updated_time,
      cached: false
    }

    # Store in cache
    Rails.cache.write(cache_key, data, expires_in: 30.minutes)
    Rails.logger.info "Cached new data for: #{cache_key}"

    data
  rescue => e
    Rails.logger.error "ForecastService Exception: #{e.message}"
    nil
  end
end
