class Yard < ApplicationRecord
    has_many :tracks
    has_many :customers

    enum :yard_type, [ :local_yard, :classification_yard ]

    validates :name, presence: true
    validates :routing_tag, presence: true
    validates :yard_type, presence: true
end
