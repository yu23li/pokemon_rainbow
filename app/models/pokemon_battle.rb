class PokemonBattle < ApplicationRecord

  belongs_to :pokemon1, class_name: "Pokemon"
  belongs_to :pokemon2, class_name: "Pokemon"
  belongs_to :pokemon_winner, class_name: "Pokemon", optional: true
  belongs_to :pokemon_loser, class_name: "Pokemon", optional: true

  with_options if: :new_record? do |new|
    new.validate :not_attack_himself
    new.validate :still_ongoing
    new.validate :current_hp_must_greater_than_0
  end

  def not_attack_himself
    pokemon1 = Pokemon.find(pokemon1_id)
    pokemon2 = Pokemon.find(pokemon2_id)

    errors.add(:base, "Pokemon tidak boleh sama") if pokemon1 == pokemon2
  end

  def still_ongoing
    pokemon = PokemonBattle.where("pokemon1_id = ? OR pokemon2_id = ? OR pokemon1_id = ? OR pokemon2_id =?", pokemon1_id, pokemon1_id, pokemon2_id, pokemon2_id)

    errors.add(:base, "Salah satu pokemon masih ongoing") if pokemon.present?
  end

  def current_hp_must_greater_than_0
    pokemon1 = Pokemon.find(pokemon1_id)
    current_hp_pokemon1 = pokemon1.current_health_point
    pokemon2 = Pokemon.find(pokemon2_id)
    current_hp_pokemon2 = pokemon2.current_health_point

    errors.add(:base, "Current Health Point harus lebih dari 0") if current_hp_pokemon1 < 1 or current_hp_pokemon2 < 1
  end
end




