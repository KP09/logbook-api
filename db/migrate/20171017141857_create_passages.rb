class CreatePassages < ActiveRecord::Migration[5.1]
  def change
    create_table :passages do |t|
      t.string :departure_port
      t.string :arrival_port
      t.datetime :departure_date
      t.datetime :arrival_date
      t.text :description
      t.float :miles
      t.float :hours
      t.float :night_hours
      t.string :role
      t.boolean :overnight
      t.boolean :tidal
      t.boolean :ocean_passage
      t.timestamps
    end
  end
end
