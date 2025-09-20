class Actor < ApplicationRecord
    self.table_name = 'actor'
    self.primary_key = 'actor_id'
  
    has_many :film_actors, foreign_key: "actor_id"
    has_many :films, through: :film_actors
    after_update :send_first_name_update_notification, if: :saved_change_to_first_name?

    def send_first_name_update_notification
      old_name = saved_change_to_first_name.first
      new_name = saved_change_to_first_name.last

      # Run job in background
      ActorNameUpdateJob.perform_later(self.id, old_name, new_name)
    end
end
  