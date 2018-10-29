require 'test_helper'

class PokemonBattleTest < ActiveSupport::TestCase

  test "can't attack with its self" do
    create_pokemon!
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon_1.id
    pokemon_battle.pokemon2_id = @pokemon_1.id
    pokemon_battle.current_turn =2
    pokemon_battle.state = "ongoing"
    pokemon_battle.pokemon_winner_id = 0
    pokemon_battle.pokemon_loser_id = 0
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = 2
    pokemon_battle.pokemon2_max_health_point = 2
    assert_not pokemon_battle.save
  end

  test "Setiap pokemon tidak boleh ada di 2 battle yang ongoing" do
    create_pokemon!
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon_1.id
    pokemon_battle.pokemon2_id = @pokemon_2.id
    pokemon_battle.current_turn = 2
    pokemon_battle.state = "ongoing"
    pokemon_battle.pokemon_winner_id = nil
    pokemon_battle.pokemon_loser_id = nil
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = 2
    pokemon_battle.pokemon2_max_health_point = 2
    pokemon_battle.save

    pokemon_battle_1 = PokemonBattle.new
    pokemon_battle_1.pokemon1_id = @pokemon_1.id
    pokemon_battle_1.pokemon2_id = @pokemon_3.id
    pokemon_battle_1.current_turn = 2
    pokemon_battle_1.state = "ongoing"
    pokemon_battle_1.pokemon_winner_id = nil
    pokemon_battle_1.pokemon_loser_id = nil
    pokemon_battle_1.experience_gain = 0
    pokemon_battle_1.pokemon1_max_health_point = 2
    pokemon_battle_1.pokemon2_max_health_point = 2
    assert_not pokemon_battle_1.save
  end

  test "Can only choose pokemon with current HP > 0" do
    create_pokemon!
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon_1.id
    pokemon_battle.pokemon2_id = @pokemon_3.id
    pokemon_battle.current_turn = 2
    pokemon_battle.state = "ongoing"
    pokemon_battle.pokemon_winner_id = nil
    pokemon_battle.pokemon_loser_id = nil
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = 2
    pokemon_battle.pokemon2_max_health_point = 2
    assert_not pokemon_battle.save
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
    @pokemon_1.name = "Test1"
    @pokemon_1.level = 1
    @pokemon_1.max_health_point = 10
    @pokemon_1.current_health_point = 10
    @pokemon_1.attack = 10
    @pokemon_1.defence = 5
    @pokemon_1.speed = 10
    @pokemon_1.current_experience = 2
    @pokemon_1.save

    @pokemon_2 = Pokemon.new
    @pokemon_2.pokedex_id = @pokedex_1.id
    @pokemon_2.name = "Test"
    @pokemon_2.level = 1
    @pokemon_2.max_health_point = 10
    @pokemon_2.current_health_point = 10
    @pokemon_2.attack = 10
    @pokemon_2.defence = 5
    @pokemon_2.speed = 10
    @pokemon_2.current_experience = 2
    @pokemon_2.save

    @pokemon_3 = Pokemon.new
    @pokemon_3.pokedex_id = @pokedex_1.id
    @pokemon_3.name = "Test2"
    @pokemon_3.level = 1
    @pokemon_3.max_health_point = 10
    @pokemon_3.current_health_point = -1
    @pokemon_3.attack = 10
    @pokemon_3.defence = 5
    @pokemon_3.speed = 10
    @pokemon_3.current_experience = 2
    @pokemon_3.save
  end
end
