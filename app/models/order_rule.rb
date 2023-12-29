class OrderRule < ApplicationRecord
    belongs_to :customer
    belongs_to :car_type
    has_many :orders

    validates :max_cars, presence: true
    validates :manutention_time, presence: true
    validates :commodity, presence: true
end
