class CreatePokedexes < ActiveRecord::Migration[5.2]
  def change
    create_table :pokedexes do |t|
      t.string :name, :limit => 45, :unique => true, :null => false
      t.integer :base_health_point, :null => false
      t.integer :base_attack, :null => false
      t.integer :base_defence, :null => false
      t.integer :base_speed, :null => false
      t.string :element_type, :limit => 225
      t.string :image_url, :limit => 225, :null => false

      t.timestamps
    end

    add_index(:pokedexes, [:name], unique: true)
  end
end
