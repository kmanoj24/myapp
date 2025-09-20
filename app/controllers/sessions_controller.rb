class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create] # Only for API mode. Skip if you're using forms.

  def new
  end

  def create
    # Support both params[:session][:email] and params[:email]
    email = params.dig(:session, :email) || params[:email]
    password = params.dig(:session, :password) || params[:password]

    user = User.find_by(email: email)

    if user&.authenticate(password)
      # 🔐 Generate JWT token
      token = JsonWebToken.encode(user_id: user.id)

      # 🎯 HTML request → redirect with flash
      if request.format.html?
        session[:user_id] = user.id

        # Background Job
        UserLoginTrackerJob.set(wait: 2.minutes).perform_later(user.id)

        redirect_to dashboard_path, notice: "Logged in successfully!"
      
      # 🧪 JSON request → return token
      else
        render json: { token: token, message: "Login successful" }, status: :ok
      end
    else
      if request.format.html?
        flash.now[:alert] = "Invalid email or password"
        render :new, status: :unprocessable_entity
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully!"
    redirect_to login_path
  end  
end
