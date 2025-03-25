require 'rails_helper'

RSpec.describe ForecastService do
  describe '.fetch' do
    it 'returns current weather data for a valid location' do
      result = ForecastService.fetch('10001') # or "London"

      expect(result).to be_a(Hash)
      expect(result[:current_temp]).to be_present
      expect(result[:condition]).to be_present
      expect(result[:icon]).to be_present
    end

    it 'returns nil for an invalid location' do
      result = ForecastService.fetch('invalid_location_123')
      expect(result).to be_nil
    end
  end
end
