class Film < ApplicationRecord
    self.table_name = 'film'
  
    has_many :film_actors, foreign_key: "film_id"
    has_many :actors, through: :film_actors
  
    has_many :film_categories, foreign_key: "film_id"
    has_many :categories, through: :film_categories
  end
  