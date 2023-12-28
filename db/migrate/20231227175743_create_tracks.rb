class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :length

      t.belongs_to :yard, index: true, foreign_key: true, null: true

      t.timestamps
    end
  end
end
