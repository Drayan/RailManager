class CarType < ApplicationRecord
    has_many :car_models, dependent: :destroy
    has_many :order_rules

    validates :name, presence: true
end
