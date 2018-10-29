require 'test_helper'

class PokemonTest < ActiveSupport::TestCase

  test "invalid Pokemon" do
    pokemon = Pokemon.new
    assert_not pokemon.save
  end

  test "name of pokemon must be unique" do
    pokemon_1 = Pokemon.new
    pokemon_1.name = "Test"
    pokemon_1.level = 1
    pokemon_1.max_health_point = 10
    pokemon_1.current_health_point = 10
    pokemon_1.attack = 10
    pokemon_1.defence = 5
    pokemon_1.speed = 10
    pokemon_1.current_experience = 2
    pokemon_1.save

    pokemon_2 = Pokemon.new
    pokemon_2.name = "Test"
    pokemon_2.level = 1
    pokemon_2.max_health_point = 10
    pokemon_2.current_health_point = 10
    pokemon_2.attack = 10
    pokemon_2.defence = 5
    pokemon_2.speed = 10
    pokemon_2.current_experience =
    assert_not pokemon_2.save
  end

  test "current_health_point must less than max_health_point" do
    pokemon = Pokemon.new
    pokemon.name = "Test"
    pokemon.level = 1
    pokemon.max_health_point = 5
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 5
    pokemon.speed = 10
    pokemon.current_experience = 2
    assert_not pokemon.save
  end

  test "current_health_point must greater than or equal 0" do
    pokemon_1 = Pokemon.new
    pokemon_1.name = "Test1"
    pokemon_1.level = 1
    pokemon_1.max_health_point = 10
    pokemon_1.current_health_point = -1
    pokemon_1.attack = 10
    pokemon_1.defence = 5
    pokemon_1.speed = 10
    pokemon_1.current_experience = 2
    assert_not pokemon_1.save
  end

  test "current_experience must greater or equal 0" do
    pokemon = Pokemon.new
    pokemon.name = "Test"
    pokemon.level = 1
    pokemon.max_health_point = 15
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 5
    pokemon.speed = 10
    pokemon.current_experience = -1
    assert_not pokemon.save
  end

  test "max_health_point must greater than 0" do
    pokemon = Pokemon.new
    pokemon.name = "Test"
    pokemon.level = 1
    pokemon.max_health_point = -1
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 5
    pokemon.speed = 10
    pokemon.current_experience = 12
    assert_not pokemon.save
  end

  test "attack must greater than 0" do
    pokemon = Pokemon.new
    pokemon.name = "Test"
    pokemon.level = 1
    pokemon.max_health_point = 2
    pokemon.current_health_point = 10
    pokemon.attack = 0
    pokemon.defence = 5
    pokemon.speed = 10
    pokemon.current_experience = 12
    assert_not pokemon.save
  end

  test "defence must greater than 0" do
    pokemon = Pokemon.new
    pokemon.name = "Test"
    pokemon.level = 1
    pokemon.max_health_point = 2
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 0
    pokemon.speed = 10
    pokemon.current_experience = 12
    assert_not pokemon.save
  end

  test "speed must greater than 0" do
    pokemon = Pokemon.new
    pokemon.name = "Test"
    pokemon.level = 1
    pokemon.max_health_point = 2
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 1
    pokemon.speed = 0
    pokemon.current_experience = 12
    assert_not pokemon.save
  end

  test "level must greater than 0" do
    pokemon = Pokemon.new
    pokemon.name = "Test"
    pokemon.level = 0
    pokemon.max_health_point = 2
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 1
    pokemon.speed = 11
    pokemon.current_experience = 12
    assert_not pokemon.save
  end
end
