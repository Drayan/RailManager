class CreateCarModels < ActiveRecord::Migration[7.0]
  def change
    create_table :car_models do |t|
      t.string :identifier, null: false
      t.references :car_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
