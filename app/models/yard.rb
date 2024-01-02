class Yard < ApplicationRecord
    has_many :tracks
    has_many :local_trains
    belongs_to :yard, optional: true

    enum :yard_type, [ :local_yard, :classification_yard ]

    validates :name, presence: true
    validates :routing_tag, presence: true
    validates :yard_type, presence: true
end
