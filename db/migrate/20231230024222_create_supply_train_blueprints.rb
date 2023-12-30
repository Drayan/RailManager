class CreateSupplyTrainBlueprints < ActiveRecord::Migration[7.1]
  def change
    create_table :supply_train_blueprints do |t|
      t.string :routing_tag, null: false
      t.string :destination
      t.integer :avg_cars, null: false
      t.integer :max_length, null: false
      t.integer :max_weight, null: false

      t.belongs_to :spawn_point, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
