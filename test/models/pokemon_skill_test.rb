require 'test_helper'

class PokemonSkillTest < ActiveSupport::TestCase

  test "invalid Pokemon skill" do
    create_pokemon!
    create_skill!

    pokemon_skill = PokemonSkill.new
    pokemon_skill.skill_id = @skill_1.id
    pokemon_skill.pokemon_id = @pokemon_1.id
    pokemon_skill.current_pp = 100
    assert_not pokemon_skill.save
  end


  test "Pokemon only have unique skill" do
    create_pokemon!
    create_skill!

    pokemon_skill = PokemonSkill.new
    pokemon_skill.skill_id = @skill_1.id
    pokemon_skill.pokemon_id = @pokemon_1.id
    pokemon_skill.current_pp = 100
    pokemon_skill.save

    pokemon_skill_1 = PokemonSkill.new
    pokemon_skill_1.skill_id = @skill_1.id
    pokemon_skill_1.pokemon_id = @pokemon_1.id
    pokemon_skill_1.current_pp = 100
    assert_not pokemon_skill_1.save
  end

  test "current pp greter than 0" do
    create_pokemon!
    create_skill!

    pokemon_skill_1 = PokemonSkill.new
    pokemon_skill_1.skill_id = @skill_1.id
    pokemon_skill_1.pokemon_id = @pokemon_1.id
    pokemon_skill_1.current_pp = -1
    assert_not pokemon_skill_1.save
  end

  test "Skill yang dipilih sesuai element type yang dimiliki pokemon" do
    create_pokemon!
    create_skill!

    pokemon_skill_1 = PokemonSkill.new
    pokemon_skill_1.skill_id = @skill_1.id
    pokemon_skill_1.pokemon_id = @pokemon_1.id
    pokemon_skill_1.current_pp = 10
    assert_not pokemon_skill_1.save
  end

  def create_pokemon!
    @pokedex_1 = Pokedex.new
    @pokedex_1.name = "Test"
    @pokedex_1.base_health_point = 10
    @pokedex_1.base_attack = 2
    @pokedex_1.base_defence = 3
    @pokedex_1.base_speed = 3
    @pokedex_1.element_type = "normal"
    @pokedex_1.image_url = "test"
    @pokedex_1.save

    @pokemon_1 = Pokemon.new
    @pokemon_1.pokedex_id = @pokedex_1.id
    @pokemon_1.name = "Test"
    @pokemon_1.level = 1
    @pokemon_1.max_health_point = 10
    @pokemon_1.current_health_point = 10
    @pokemon_1.attack = 10
    @pokemon_1.defence = 5
    @pokemon_1.speed = 10
    @pokemon_1.current_experience = 2
    @pokemon_1.save
  end

  def create_skill!
    @skill_1 = Skill.new
    @skill_1.name = "hyperspace-fury"
    @skill_1.power = 100
    @skill_1.max_pp = 5
    @skill_1.element_type = "dark"
    @skill_1.save

    @skill_2 = Skill.new
    @skill_2.name = "hyperspace-fury"
    @skill_2.power = 100
    @skill_2.max_pp = 5
    @skill_2.element_type = "dark"
    @skill_2.save
  end

end

