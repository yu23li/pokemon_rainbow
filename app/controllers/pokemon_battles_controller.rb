class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [:show, :edit, :update, :destroy, :attack, :surrender]
  before_action :set_attacker_defender, only: [:attack, :surrender]

  def index
    @pokemon_battle = PokemonBattle.reorder("created_at DESC").all.paginate(:page => params[:page], :per_page => 5)
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
    if @current_turn % 2 == 0
      attack_action(skill_id: @skill_id, attacker: @pokemon2, defender: @pokemon1)
    else
      attack_action(skill_id: @skill_id, attacker: @pokemon1, defender: @pokemon2)
    end
  end

  def surrender

    if @current_turn % 2 == 0

      game_finish(winner: @pokemon1, loser: @pokemon2)
    else

      game_finish(winner: @pokemon2, loser: @pokemon1)
    end
  end

  private

  def set_pokemon_battle
    @pokemon_battle = PokemonBattle.find(params[:id])
  end

  def pokemon_battle_params
    params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id)
  end

  def set_attacker_defender
    @pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    @pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
    @current_turn = @pokemon_battle.current_turn
    @skill_id = params[:skill_id]
  end

  def bonus(winner:)
    bonus = PokemonBattleCalculator.calculate_level_up_extra_state
    health_point = winner.max_health_point + bonus.health_point
    attack_point = winner.attack + bonus.attack_point
    defence_point = winner.defence + bonus.defence_point
    speed_point = winner.speed + bonus.speed_point

    winner.update(max_health_point: health_point,
                    attack: attack_point,
                    defence: defence_point,
                    speed: speed_point)
  end

  def game_finish(winner:, loser:)
     experience_gain = PokemonBattleCalculator.calculate_experience(loser.level)
     winner_current_experience = winner.current_experience
     total_exprience_pokemon_winner = winner_current_experience + experience_gain
     @pokemon_battle.update(pokemon_winner_id: winner.id,
                            pokemon_loser_id: loser.id,
                            state: "finish",
                            experience_gain: experience_gain)
     winner.update(current_experience: total_exprience_pokemon_winner)
      #level_up?
     level_pokemon_winner = winner.level
     level_up = PokemonBattleCalculator.level_up?(level_pokemon_winner, total_exprience_pokemon_winner)
     if level_up == true
        experience_turn = total_exprience_pokemon_winner / 100
        bonus(winner: winner)
        level = Math.log2(experience_turn).to_i + 1
        winner.update(level: level)
     end
     flash[:success] = "Selamat #{winner.name} memenangkan pertandingan ini!"
     redirect_to @pokemon_battle
  end

  def attack_action(skill_id:, attacker:, defender:)
    pokemon_skill = PokemonSkill.where("skill_id = ? AND pokemon_id = ?", skill_id, attacker).first
    damage = PokemonBattleCalculator.calculate_damage(attacker, defender, skill_id)
    current_hp = defender.current_health_point - damage
    pokemon_current_hp = current_hp < 0 ? 0 : current_hp
    current_pp = pokemon_skill.current_pp - 1
    current_turn = @pokemon_battle.current_turn + 1

    if pokemon_skill.current_pp == 0
        flash[:error] = "#{attacker.name} sudah tidak punya kekuatan!"
        redirect_to @pokemon_battle
    else
      if pokemon_current_hp == 0
         game_finish(winner:attacker, loser:defender)
      end
      defender.update(current_health_point: pokemon_current_hp)
      pokemon_skill.update(current_pp: current_pp)
      @pokemon_battle.update(current_turn: current_turn)
      flash[:success] = "GOOD JOB #{attacker.name}"
      redirect_to @pokemon_battle
    end
  end
end
