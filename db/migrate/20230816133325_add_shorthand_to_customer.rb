class AddShorthandToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :shorthand, :string, null: false
  end
end
