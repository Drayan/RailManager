class CreateYards < ActiveRecord::Migration[7.1]
  def change
    create_table :yards do |t|
      t.string :name
      t.string :routing_tag

      t.timestamps
    end
  end
end
