class Customer < ApplicationRecord
    self.table_name = 'customer'
    scope :active, -> { where(activebool: false) }
    default_scope { where(store_id: 2) }

    belongs_to :address, foreign_key: "address_id"
    has_many :rentals, foreign_key: "customer_id"
    has_many :payments, foreign_key: "customer_id"
end