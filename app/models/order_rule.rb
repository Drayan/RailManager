class OrderRule < ApplicationRecord
    belongs_to :customer
    has_one :car_type
end
