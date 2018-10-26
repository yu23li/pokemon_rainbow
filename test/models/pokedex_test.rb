require 'test_helper'

class PokedexTest < ActiveSupport::TestCase

  test "inavalid Pokedex" do
    pokedex = Pokedex.new
    assert_not pokedex.save
  end

  test "name must be unique" do
    pokedex_1 = Pokedex.new
    pokedex_1.name = "Test"
    pokedex_1.base_health_point = 10
    pokedex_1.base_attack = 2
    pokedex_1.base_defence = 3
    pokedex_1.base_speed = 3
    pokedex_1.element_type = "normal"
    pokedex_1.image_url = "test"
    pokedex_1.save
    assert pokedex_1.save

    pokedex_2 = Pokedex.new
    pokedex_2.name = "Test"
    pokedex_2.base_health_point = 4
    pokedex_2.base_attack = 3
    pokedex_2.base_defence = 2
    pokedex_2.base_speed = 10
    pokedex_2.element_type = "normal"
    pokedex_2.image_url = "test"
    assert_not pokedex_2.save
  end

  test "Element type must be in Element_Type" do
    pokedex_1 = Pokedex.new
    pokedex_1.name = "Test"
    pokedex_1.base_health_point = 10
    pokedex_1.base_attack = 2
    pokedex_1.base_defence = 3
    pokedex_1.base_speed = 3
    pokedex_1.element_type = "test"
    pokedex_1.image_url = "test"
    assert_not pokedex_1.save

    pokedex_2 = Pokedex.new
    pokedex_2.name = "Test"
    pokedex_2.base_health_point = 10
    pokedex_2.base_attack = 2
    pokedex_2.base_defence = 3
    pokedex_2.base_speed = 3
    pokedex_2.element_type = "normal"
    pokedex_2.image_url = "test"
    assert pokedex_2.save
  end

  test "base_health_point must greater than 0 " do
    pokedex_1 = Pokedex.new
    pokedex_1.name = "Test"
    pokedex_1.base_health_point = -2
    pokedex_1.base_attack = 2
    pokedex_1.base_defence = 3
    pokedex_1.base_speed = 3
    pokedex_1.element_type = "test"
    pokedex_1.image_url = "test"
    assert_not pokedex_1.save
  end

  test "base_attack must greater than 0 " do
    pokedex_1 = Pokedex.new
    pokedex_1.name = "Test"
    pokedex_1.base_health_point = 10
    pokedex_1.base_attack = -2
    pokedex_1.base_defence = 3
    pokedex_1.base_speed = 3
    pokedex_1.element_type = "test"
    pokedex_1.image_url = "test"
    assert_not pokedex_1.save
  end

  test "base_defence must greater than 0 " do
    pokedex_1 = Pokedex.new
    pokedex_1.name = "Test"
    pokedex_1.base_health_point = 10
    pokedex_1.base_attack = 2
    pokedex_1.base_defence = -3
    pokedex_1.base_speed = 3
    pokedex_1.element_type = "test"
    pokedex_1.image_url = "test"
    assert_not pokedex_1.save
  end

  test "base_speed must greater than 0 " do
    pokedex_1 = Pokedex.new
    pokedex_1.name = "Test"
    pokedex_1.base_health_point = 10
    pokedex_1.base_attack = 2
    pokedex_1.base_defence = 3
    pokedex_1.base_speed = -3
    pokedex_1.element_type = "test"
    pokedex_1.image_url = "test"
    assert_not pokedex_1.save
  end

end
