class CreateCarTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :car_types do |t|
      t.string :type, null: false
      t.references :order_rule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
