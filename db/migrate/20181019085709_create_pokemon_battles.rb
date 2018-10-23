class CreatePokemonBattles < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemon_battles do |t|
      t.integer :pokemon1_id, :null => false
      t.integer :pokemon2_id, :null => false
      t.integer :current_turn
      t.string :state
      t.integer :pokemon_winner_id
      t.integer :pokemon_loser_id
      t.integer :experience_gain
      t.integer :pokemon1_max_health_point
      t.integer :pokemon2_max_health_point

      t.timestamps
    end
    add_foreign_key :pokemon_battles, :pokemons, column: :pokemon1_id
    add_foreign_key :pokemon_battles, :pokemons, column: :pokemon2_id
    add_foreign_key :pokemon_battles, :pokemons, column: :pokemon_winner_id
    add_foreign_key :pokemon_battles, :pokemons, column: :pokemon_loser_id
  end
end
