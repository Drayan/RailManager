class CarType < ApplicationRecord
    has_many :order_rules
    has_many :car_models
end
