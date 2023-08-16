class ChangeTypeColumnNameInCarTypes < ActiveRecord::Migration[7.0]
  def change
    remove_column :car_types, :type
    add_column :car_types, :type_name, :string, null: false
  end
end
