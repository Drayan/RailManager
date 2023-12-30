class AddYardType < ActiveRecord::Migration[7.1]
  def change
    change_table :yards do |t|
      t.integer :type
      t.belongs_to :yard, index: true, null: true
    end

    change_table :customers do |t|
      t.belongs_to :yard, index: true, foreign_key: true
    end
  end
end
