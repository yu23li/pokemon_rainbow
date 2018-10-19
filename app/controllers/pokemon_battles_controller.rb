class PokemonBattlesController < ApplicationController
  def index
    @pokemon_battles = PokemonBattle.all.paginate(:page => params[:page], :per_page => 5)
    @pokemon_select = Pokemon.all.collect{ |u| [u.name, u.id] }
  end

  def new
    @pokemon_battles.new
  end

  def destroy
  end
end
