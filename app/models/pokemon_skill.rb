class PokemonSkill < ApplicationRecord
  belongs_to :pokemon
  belongs_to :skill

  validates_uniqueness_of :skill_id, :scope => :pokemon_id
  validates :current_pp, numericality: { greater_than: 0 }
  validate :element_type
  validate :current_pp_less_than_max_pp
  validate :four_skill

  def current_pp_less_than_max_pp
    skill = Skill.find(skill_id)
    max_pp = skill.max_pp
    errors.add(:current_pp, "Current PP must less than Max PP") if current_pp > max_pp
  end

  def element_type
    pokemon = Pokemon.find(pokemon_id)
    pokedex_element_type = pokemon.pokedex.element_type
    skill_element_type = Skill.where(element_type: pokedex_element_type).pluck(:id)
    errors.add(:skill_id, "Element Type Skill Tidak Sesuai") if !skill_element_type.include?(skill_id)
  end

  def four_skill
    pokemon = Pokemon.find(pokemon_id)
    pokemon_skill = PokemonSkill.where(pokemon_id: pokemon.id).count
    errors.add(:skill_id, "Pokemon tidak boleh memiliki lebih dari 4 Skill") if pokemon_skill > 3
  end

end
