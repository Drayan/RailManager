class Customer < ApplicationRecord
    has_many :order_rules, dependent: :destroy
end
