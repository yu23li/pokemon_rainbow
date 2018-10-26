require 'test_helper'

class PokemonSkillTest < ActiveSupport::TestCase
end
=begin  test 'one skill can have multiple pokemon' do
    skill = Skill.last
    require "pry"
    binding.pry

    pokemon_1 = skill.pokemon.create
    pokemon_2 = skill.pokemon.create

    assert skill.pokemon.size > 1, "skill should have multiple pokemon"
    assert_equal pokemon_1.skill, pokemon_2.skill, "skills are not the same"
  end
  =end

