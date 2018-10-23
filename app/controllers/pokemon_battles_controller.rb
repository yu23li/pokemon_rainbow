class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [:show, :edit, :update, :destroy]

  def index
    @pokemon_battle = PokemonBattle.all.paginate(:page => params[:page], :per_page => 5)

  end

  def show
    @pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    @pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)

    @skill_select1 = @pokemon1.pokemon_skills.collect{ |u| ["#{u.skill.name}(#{u.current_pp}/#{u.skill.max_pp})", u.id] }
    @skill_select2 = @pokemon2.pokemon_skills.collect{ |u| ["#{u.skill.name}(#{u.current_pp}/#{u.skill.max_pp})", u.id] }
  end

  def new
    @pokemon_battle = PokemonBattle.new
    @pokemon_select = Pokemon.all.collect{ |u| [u.name, u.id] }
  end

  def create
    @pokemon_battle = PokemonBattle.new(pokemon_battle_params)
    pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)

    @pokemon_battle.current_turn = 1
    @pokemon_battle.state = "ongoing"
    @pokemon_battle.experience_gain = 0
    @pokemon_battle.pokemon1_max_health_point = pokemon1.max_health_point
    @pokemon_battle.pokemon2_max_health_point = pokemon2.max_health_point
    @pokemon_select = Pokemon.all.collect{ |u| [u.name, u.id] }

    if @pokemon_battle.save
      redirect_to @pokemon_battle, notice: 'Pokemon was successfully created.'
    else
      render :new
    end
  end

  def destroy
     if @pokemon_battle.destroy
      redirect_to pokemon_battles_path, notice: 'Pokemon Skill was successfully destroyed.'
    end
  end

  def attack
    #@pokemon = params[:commit]
    pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
    current_turn = @pokemon_battle.current_turn

    if current_turn % 2 == 0
      PokemonBattleCalculator.calculate_damage(pokemon2, pokemon1, skill_id)
    else
      PokemonBattleCalculator.calculate_damage(pokemon1, pokemon2, skill_id)
    end

  end

  private

  def set_pokemon_battle
    @pokemon_battle = PokemonBattle.find(params[:id])
  end

  def pokemon_battle_params
    params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id)
  end

end
