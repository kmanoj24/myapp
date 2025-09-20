# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    include Pundit
  
    helper_method :current_user  # 👉 So you can use in views too
  
    private
  
    def current_user
      @current_user
    end
  
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referer || root_path)
    end
  end
  