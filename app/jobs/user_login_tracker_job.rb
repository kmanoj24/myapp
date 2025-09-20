class UserLoginTrackerJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    return unless user

    puts "User #{user.email} logged in. Do something useful here..."
    # Example: track login, send follow-up email, etc.
  end
end
