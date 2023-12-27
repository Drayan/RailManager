class CreateOrderRules < ActiveRecord::Migration[7.1]
  def change
    create_table :order_rules do |t|
      t.string :commodity
      t.integer :max_cars
      t.boolean :is_loaded
      t.integer :manutention_time

      t.belongs_to :customer, index: true, foreign_key: true
      t.belongs_to :car_type, index: true, foreign_key: true

      t.timestamps
    end
  end
end
