class PokemonBattleLog < ApplicationRecord
  belongs_to :attacker, class_name: "Pokemon"
  belongs_to :defender, class_name: "Pokemon"
  belongs_to :skill
end
