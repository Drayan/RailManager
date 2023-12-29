class Order < ApplicationRecord
  belongs_to :order_rule
  belongs_to :train, optional: true
  belongs_to :track, optional: true

end
