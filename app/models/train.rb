class Train < ApplicationRecord
    belongs_to :track, optional: true
end
