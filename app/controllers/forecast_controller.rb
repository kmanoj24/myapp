class ForecastController < ApplicationController
  def index
  end

  def show
    address = params[:address]
    @forecast = ForecastService.fetch(address)
    render :show
  end
end
