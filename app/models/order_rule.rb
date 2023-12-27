class OrderRule < ApplicationRecord
    belongs_to :customer
    belongs_to :car_type

    validates :max_cars, presence: true
    validates :manutention_time, presence: true
    validates :commodity, presence: true
end
