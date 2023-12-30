class Track < ApplicationRecord
    belongs_to :yard, optional: true
    has_one :train
    has_one :spawn_point
    has_many :orders

    validates :name, presence: true
    validates :length, presence: true
end
