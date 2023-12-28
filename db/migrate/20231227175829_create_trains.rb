class CreateTrains < ActiveRecord::Migration[7.1]
  def change
    create_table :trains do |t|
      t.string :routing_tag
      t.integer :length
      t.integer :weigth

      t.belongs_to :track, index: true, foreign_key: true, null: true

      t.timestamps
    end
  end
end
