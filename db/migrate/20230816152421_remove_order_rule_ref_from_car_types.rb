class RemoveOrderRuleRefFromCarTypes < ActiveRecord::Migration[7.0]
  def change
    remove_reference :car_types, :order_rule, foreign_key: true, index: true
  end
end
