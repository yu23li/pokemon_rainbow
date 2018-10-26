class Skill < ApplicationRecord
  has_many :pokemon_skills
  has_many :pokemons, through: :pokemon_skills

  ELEMENT_TYPE = ["normal","fire","fighting","water","flying","grass","poison","electric","ground","psychic",
                  "rock","ice","bug","dragon","ghost","dark","steel","fairy"]


  validates :name, length: { maximum: 45 }, presence: true, uniqueness: true
  validates :power, numericality: { greater_than: 0 }
  validates :max_pp, numericality: { greater_than: 0 }
  validates :element_type, presence: true, inclusion: { :in => ELEMENT_TYPE }

end

