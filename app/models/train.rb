class Train < ApplicationRecord
    belongs_to :track, optional: true
    has_many :orders
end
