class RemoveCustomerYardId < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :yard_id
  end
end
