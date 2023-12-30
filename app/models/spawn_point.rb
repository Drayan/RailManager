class SpawnPoint < ApplicationRecord
  belongs_to :track, optional: false
  has_many :supply_train_blueprints
end
