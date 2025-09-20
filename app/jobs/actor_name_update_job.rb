class ActorNameUpdateJob < ApplicationJob
  queue_as :default

  def perform(actor_id, old_name, new_name)
    
    actor = Actor.find_by(actor_id: actor_id)
    Rails.logger.info "🚀 Notification: #{actor&.last_name}'s name changed from #{old_name} to #{new_name}"
    # OR send mail / webhook etc
  end
end
