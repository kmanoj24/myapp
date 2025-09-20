class DashboardController < ApplicationController
  before_action :authorize_request

  def index
    # authorize Customer
    @customers = Customer.page(params[:page]).per(10)
    @user = current_user  # ✅ Now this will work
  end

  private

  def authorize_request
    token = extract_token_from_header
    decoded = JsonWebToken.decode(token) if token.present?

    if decoded&.dig(:user_id)
      @current_user = User.find_by(id: decoded[:user_id])
    elsif session[:user_id].present?
      @current_user = User.find_by(id: session[:user_id])
    end

    unless @current_user
      respond_to do |format|
        format.html { redirect_to login_path, alert: 'You must be logged in to access this page.' }
        format.json { render json: { error: 'Unauthorized access' }, status: :unauthorized }
      end
    end
  end

  def extract_token_from_header
    header = request.headers['Authorization']
    header&.split(' ')&.last
  end
end
