require 'test_helper'

class PokemonBattleLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get read" do
    get pokemon_battle_logs_read_url
    assert_response :success
  end

  test "should get delete" do
    get pokemon_battle_logs_delete_url
    assert_response :success
  end

end
