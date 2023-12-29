class Track < ApplicationRecord
    belongs_to :yard, optional: true
    has_one :train, optional: true
    has_many :orders

    validates :name, presence: true
    validates :length, presence: true
end
