class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :routing_tag
      t.string :destinations

      t.timestamps
    end
  end
end
