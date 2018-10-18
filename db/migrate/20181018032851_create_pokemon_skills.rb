class CreatePokemonSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemon_skills do |t|
      t.integer :skill_id
      t.integer :pokemon_id
      t.integer :current_pp

      t.timestamps
    end
  end
end
