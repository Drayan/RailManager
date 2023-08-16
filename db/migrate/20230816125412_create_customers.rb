class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :railroad, null: false
      t.string :local
      t.string :routingTag

      t.timestamps
    end
  end
end
