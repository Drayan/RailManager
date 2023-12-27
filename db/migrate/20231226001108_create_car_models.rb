class CreateCarModels < ActiveRecord::Migration[7.1]
  def change
    create_table :car_models do |t|
      t.string :FQDN
      t.belongs_to :car_type, index: true, foreign_key: true

      t.timestamps
    end
  end
end
