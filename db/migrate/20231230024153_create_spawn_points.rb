class CreateSpawnPoints < ActiveRecord::Migration[7.1]
  def change
    create_table :spawn_points do |t|
      t.belongs_to :track, index: true, foreign_key: true, null: false
      t.boolean :allow_supply_train, null: false

      t.timestamps
    end
  end
end
