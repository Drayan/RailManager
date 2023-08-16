class CreateOrderRules < ActiveRecord::Migration[7.0]
  def change
    create_table :order_rules do |t|
      t.string :commodity
      t.integer :dropoff_state, null: false
      t.integer :pickup_state, null: false
      t.integer :max_cars, null: false
      t.integer :current_cars, default: 0
      t.datetime :last_order
      t.datetime :last_delivery
      t.integer :hazmat

      t.timestamps
    end
  end
end
