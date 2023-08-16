class AddCustomerRefToOrderRules < ActiveRecord::Migration[7.0]
  def change
    add_reference :order_rules, :customer, null: false, foreign_key: true
  end
end
