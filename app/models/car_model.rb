class CarModel < ApplicationRecord
    belongs_to :car_type

    validates :FQDN, presence: true
end
