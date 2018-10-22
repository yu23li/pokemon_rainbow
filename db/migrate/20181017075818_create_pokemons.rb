class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.integer :pokedex_id
      t.string :name, :limit => 45, :null => false
      t.integer :level
      t.integer :max_health_point
      t.integer :current_health_point
      t.integer :attack
      t.integer :defence
      t.integer :speed
      t.integer :current_experience

      t.timestamps
    end

    add_foreign_key :pokemons, :pokedexes

    add_index(:pokemons, [:name], unique: true)
  end
end