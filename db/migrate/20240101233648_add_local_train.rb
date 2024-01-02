class AddLocalTrain < ActiveRecord::Migration[7.1]
  def change
    change_table :customers do |t|
      t.remove_belongs_to :yards
      t.remove_index :yard_id
    end

    remove_foreign_key :customers, :yards

    create_table :local_trains do |t|
      t.string :name, null: false
      t.string :routing_tag, null: false

      t.belongs_to :yards, index: true, foreign_key: true, null: false

      t.timestamps
    end

    change_table :customers do |t|
      t.belongs_to :local_trains, index: true, foreign_key: true
    end
  end
end
