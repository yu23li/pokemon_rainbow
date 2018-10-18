require 'test_helper'

class PokemonSkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get pokemon_skills_create_url
    assert_response :success
  end

  test "should get destroy" do
    get pokemon_skills_destroy_url
    assert_response :success
  end

end
