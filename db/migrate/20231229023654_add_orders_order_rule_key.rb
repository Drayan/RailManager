class AddOrdersOrderRuleKey < ActiveRecord::Migration[7.1]
  def change
    change_table :orders do |t|
      t.belongs_to :order_rule, index:true, foreign_key: true, null: false
    end
  end
end
