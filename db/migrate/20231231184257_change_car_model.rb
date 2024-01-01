class ChangeCarModel < ActiveRecord::Migration[7.1]
  def change
    change_table :car_models do |t|
      t.numeric :empty_weight
      t.numeric :max_weight
      t.numeric :length
      t.numeric :coupler_offset
      t.numeric :bolster_length
    end
  end
end
