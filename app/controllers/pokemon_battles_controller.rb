class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [:show, :edit, :update, :destroy, :attack]

  def index
    @pokemon_battle = PokemonBattle.all.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    @pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)

    @skill_select1 = @pokemon1.pokemon_skills.collect{ |u| ["#{u.skill.name}(#{u.current_pp}/#{u.skill.max_pp})", u.skill.id] }
    @skill_select2 = @pokemon2.pokemon_skills.collect{ |u| ["#{u.skill.name}(#{u.current_pp}/#{u.skill.max_pp})", u.skill.id] }
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
    pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
    skill_id = params[:skill_id]
    current_turn = @pokemon_battle.current_turn

    if current_turn % 2 == 0

      pokemon_skill = PokemonSkill.where("skill_id = ? AND pokemon_id = ?", skill_id, pokemon2).first
      damage = PokemonBattleCalculator.calculate_damage(pokemon2, pokemon1, skill_id)
      current_hp = pokemon1.current_health_point - damage
      pokemon_current_hp = current_hp < 0 ? 0 : current_pp
      current_pp = pokemon_skill.current_pp - 1
      current_turn = @pokemon_battle.current_turn + 1

      if pokemon_skill.current_pp == 0
          flash[:error] = "Pokemon 2 sudah tidak punya kekuatan!"
          redirect_to @pokemon_battle
      else
        if pokemon_current_hp == 0
         @pokemon_battle.update(pokemon_winner_id: pokemon2.id)
         @pokemon_battle.update(pokemon_loser_id: pokemon1.id)
         @pokemon_battle.update(state: "finish")

          flash[:success] = "Pokemon 2 Menang"
        end
        pokemon1.update(current_health_point: pokemon_current_hp)
        pokemon_skill.update(current_pp: current_pp)
        @pokemon_battle.update(current_turn: current_turn)

        redirect_to @pokemon_battle, notice: "GOOD JOB POKEMON 2"
      end

    else
      pokemon_skill = PokemonSkill.where("skill_id = ? AND pokemon_id = ?", skill_id, pokemon1).first
      damage = PokemonBattleCalculator.calculate_damage(pokemon1, pokemon2, skill_id)
      current_hp = pokemon2.current_health_point - damage
      pokemon_current_hp = current_hp < 0 ? 0 : current_pp
      current_pp = pokemon_skill.current_pp - 1
      current_turn = @pokemon_battle.current_turn + 1

      if pokemon_skill.current_pp == 0
        flash[:error] = "Pokemon 1 sudah tidak punya kekuatan!"
        redirect_to @pokemon_battle
      else

       if pokemon_current_hp == 0
         @pokemon_battle.update(pokemon_winner_id: pokemon1.id)
         @pokemon_battle.update(pokemon_loser_id: pokemon2.id)
         @pokemon_battle.update(state: "finish")

         flash[:success] = "Pokemon 1 Menang"
       end
        pokemon2.update(current_health_point: pokemon_current_hp)
        pokemon_skill.update(current_pp: current_pp)
        @pokemon_battle.update(current_turn: current_turn)

        flash[:success] = "GOOD JOB POKEMON 1"
        redirect_to @pokemon_battle
      end
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
