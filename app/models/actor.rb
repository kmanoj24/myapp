class Actor < ApplicationRecord
    self.table_name = 'actor'
  
    has_many :film_actors, foreign_key: "actor_id"
    has_many :films, through: :film_actors
  end
  