class Track < ApplicationRecord
    belongs_to :yard, optional: true
    has_one :train

    validates :name, presence: true
    validates :length, presence: true
end
