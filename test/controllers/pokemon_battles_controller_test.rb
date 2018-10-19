require 'test_helper'

class PokemonBattlesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get pokemon_battles_create_url
    assert_response :success
  end

  test "should get destroy" do
    get pokemon_battles_destroy_url
    assert_response :success
  end

end
