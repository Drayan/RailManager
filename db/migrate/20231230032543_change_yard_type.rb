class ChangeYardType < ActiveRecord::Migration[7.1]
  def change
    rename_column :yards, :type, :yard_type
  end
end
