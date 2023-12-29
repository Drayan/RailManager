class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :ordered_count
      t.integer :status
      t.string :routing_tag

      t.belongs_to :train, index: true, foreign_key: true, null: true
      t.belongs_to :track, index: true, foreign_key: true, null: true

      t.timestamps
    end
  end
end
