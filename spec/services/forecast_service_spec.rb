require 'rails_helper'

RSpec.describe ForecastService do
  describe '.fetch' do
    it 'returns forecast data for a valid ZIP code' do
      result = ForecastService.fetch('10001') # You can change this

      expect(result).to be_a(Hash)
      expect(result[:current_temp]).to be_present
      expect(result[:high]).to be_present
      expect(result[:low]).to be_present
    end

    it 'returns nil for an invalid ZIP code' do
      result = ForecastService.fetch('invalid_location_123')
      expect(result).to be_nil
    end
  end
end
