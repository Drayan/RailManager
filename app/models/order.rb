class Order < ApplicationRecord
  belongs_to :order_rule
  belongs_to :train, optional: true
  belongs_to :track, optional: true

  enum :status, [ :completed, :pending, :in_transit, :in_local_yard, :ready_for_delivery, :ready_for_setout ]
end
