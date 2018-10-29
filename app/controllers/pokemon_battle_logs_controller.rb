class PokemonBattleLogsController < ApplicationController
  before_action :set_pokemon_battle_log, only: [:destroy]

  def index
    @pokemon_battle_log = PokemonBattleLog.reorder("created_at DESC").all.paginate(:page => params[:page], :per_page => 5)
  end

  def destroy
     if @pokemon_battle_log.destroy
      redirect_to pokemon_url(@pokemon_battle_log.pokemon_battle_id), notice: 'Pokemon Skill was successfully destroyed.'
    end
  end

  def set_pokemon_battle_log
    @pokemon_battle_log = PokemonBattleLog.find(params[:id])
  end

end
