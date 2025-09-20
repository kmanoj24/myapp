class Api::CustomersController < ApplicationController
  before_action :set_customer, only: [:activate, :profile, :destroy]
  def search
  end

  def export
  end

  def profile
    @customer
    render json: @customer
  end

  def activate
    @customer
    @customer.update(active: true)
    render json: { message: "Customer activated" }
  end

  def destroy
    @customer.destroy
    head :no_content
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:store_id, :first_name, :last_name, :email, :address_id, :activebool, :create_date, :active)
  end
end
