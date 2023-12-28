class Yard < ApplicationRecord
    has_many :tracks

    validates :name, presence: true
    validates :routing_tag, presence: true
end
