class ColumnCorrection < ActiveRecord::Migration[7.1]
  def change
    rename_column :customers, :local_trains_id, :local_train_id
    rename_column :local_trains, :yards_id, :yard_id

    remove_foreign_key :customers, :local_trains
    remove_foreign_key :local_trains, :yards

    add_foreign_key :customers, :local_trains
    add_foreign_key :local_trains, :yards
  end
end
