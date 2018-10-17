require "application_system_test_case"

class PokemonsTest < ApplicationSystemTestCase
  setup do
    @pokemon = pokemons(:one)
  end

  test "visiting the index" do
    visit pokemons_url
    assert_selector "h1", text: "Pokemons"
  end

  test "creating a Pokemon" do
    visit pokemons_url
    click_on "New Pokemon"

    fill_in "Attack", with: @pokemon.attack
    fill_in "Current Experience", with: @pokemon.current_experience
    fill_in "Current Health Point", with: @pokemon.current_health_point
    fill_in "Defence", with: @pokemon.defence
    fill_in "Level", with: @pokemon.level
    fill_in "Max Health Point", with: @pokemon.max_health_point
    fill_in "Name", with: @pokemon.name
    fill_in "Pokedex", with: @pokemon.pokedex_id
    fill_in "Speed", with: @pokemon.speed
    click_on "Create Pokemon"

    assert_text "Pokemon was successfully created"
    click_on "Back"
  end

  test "updating a Pokemon" do
    visit pokemons_url
    click_on "Edit", match: :first

    fill_in "Attack", with: @pokemon.attack
    fill_in "Current Experience", with: @pokemon.current_experience
    fill_in "Current Health Point", with: @pokemon.current_health_point
    fill_in "Defence", with: @pokemon.defence
    fill_in "Level", with: @pokemon.level
    fill_in "Max Health Point", with: @pokemon.max_health_point
    fill_in "Name", with: @pokemon.name
    fill_in "Pokedex", with: @pokemon.pokedex_id
    fill_in "Speed", with: @pokemon.speed
    click_on "Update Pokemon"

    assert_text "Pokemon was successfully updated"
    click_on "Back"
  end

  test "destroying a Pokemon" do
    visit pokemons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pokemon was successfully destroyed"
  end
end
