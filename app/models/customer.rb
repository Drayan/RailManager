class Customer < ApplicationRecord
    has_many :order_rules, dependent: :destroy
    belongs_to :local_train
end
