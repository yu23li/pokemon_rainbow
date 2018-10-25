class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [:show, :edit, :update, :destroy, :attack, :surrender]

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
    pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    pokemon1_current_experience = pokemon1.current_experience
    pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
    pokemon2_current_experience = pokemon2.current_experience
    skill_id = params[:skill_id]
    current_turn = @pokemon_battle.current_turn
    bonus = PokemonBattleCalculator.calculate_level_up_extra_state

    if current_turn % 2 == 0

      pokemon_skill = PokemonSkill.where("skill_id = ? AND pokemon_id = ?", skill_id, pokemon2).first
      damage = PokemonBattleCalculator.calculate_damage(pokemon2, pokemon1, skill_id)
      current_hp = pokemon1.current_health_point - damage
      pokemon_current_hp = current_hp < 0 ? 0 : current_hp
      current_pp = pokemon_skill.current_pp - 1
      current_turn = @pokemon_battle.current_turn + 1
      experience_gain = PokemonBattleCalculator.calculate_experience(pokemon1.level)

      if pokemon_skill.current_pp == 0
          flash[:error] = "#{@pokemon_battle.pokemon2.name} sudah tidak punya kekuatan!"
          redirect_to @pokemon_battle
      else
        if pokemon_current_hp == 0
           health_point = pokemon2.max_health_point + bonus.health_point
           attack_point = pokemon2.attack + bonus.attack_poin
           defence_point = pokemon2.defence + bonus.defence_point
           speed_point = pokemon2.speed + bonus.speed_point
           total_exprience_pokemon_winner = pokemon2_current_experience + experience_gain
           @pokemon_battle.update(pokemon_winner_id: pokemon2.id)
           @pokemon_battle.update(pokemon_loser_id: pokemon1.id)
           @pokemon_battle.update(pokemon_winner_id: pokemon2.id,
                                  pokemon_loser_id: pokemon1.id,
                                  state: "finish",
                                  experience_gain: experience_gain)
           pokemon2.update(max_health_point: health_point,
                           attack: attack_point,
                           defence: defence_point,
                           speed: speed_point,
                           current_experience: total_exprience_pokemon_winner)

          #level_up?
         level_pokemon_winner = pokemon1.level
         level_up = PokemonBattleCalculator.level_up?(level_pokemon_winner, total_exprience_pokemon_winner)

         if level_up == true
          experience_turn = total_exprience_pokemon_winner / 100
          level = Math.log2(experience_turn).to_i + 1
          pokemon2.update(level: level)
         end

        end
        pokemon1.update(current_health_point: pokemon_current_hp)
        pokemon_skill.update(current_pp: current_pp)
        @pokemon_battle.update(current_turn: current_turn)

        redirect_to @pokemon_battle, notice: "GOOD JOB #{@pokemon_battle.pokemon2.name}"
      end

    else
      pokemon_skill = PokemonSkill.where("skill_id = ? AND pokemon_id = ?", skill_id, pokemon1).first
      damage = PokemonBattleCalculator.calculate_damage(pokemon1, pokemon2, skill_id)
      current_hp = pokemon2.current_health_point - damage
      pokemon_current_hp = current_hp < 0 ? 0 : current_hp
      current_pp = pokemon_skill.current_pp - 1
      current_turn = @pokemon_battle.current_turn + 1
      experience_gain = PokemonBattleCalculator.calculate_experience(pokemon2.level)

      if pokemon_skill.current_pp == 0
        flash[:error] = "#{@pokemon_battle.pokemon1.name} sudah tidak punya kekuatan!"
        redirect_to @pokemon_battle
      else

       if pokemon_current_hp == 0
          health_point = pokemon1.max_health_point + bonus.health_point
          attack_point = pokemon1.attack + bonus.attack_point
          defence_point = pokemon1.defence + bonus.defence_point
          speed_point = pokemon1.speed + bonus.speed_point
          total_exprience_pokemon_winner = pokemon1_current_experience + experience_gain
          @pokemon_battle.update(pokemon_winner_id: pokemon1.id,
                                 pokemon_loser_id: pokemon2.id,
                                 state: "finish",
                                 experience_gain: experience_gain)
          pokemon1.update(max_health_point: health_point,
                          attack: attack_point,
                          defence: defence_point,
                          speed: speed_point,
                          current_experience: total_exprience_pokemon_winner)


          #level_up?
         level_pokemon_winner = pokemon1.level
         level_up = PokemonBattleCalculator.level_up?(level_pokemon_winner, total_exprience_pokemon_winner)

         if level_up == true
          experience_turn = total_exprience_pokemon_winner / 100
          level = Math.log2(experience_turn).to_i + 1
          pokemon1.update(level: level)
         end

         flash[:success] = "#{@pokemon_battle.pokemon1.name} Menang"
       end
        pokemon2.update(current_health_point: pokemon_current_hp)
        pokemon_skill.update(current_pp: current_pp)
        @pokemon_battle.update(current_turn: current_turn)

        flash[:success] = "GOOD JOB #{@pokemon_battle.pokemon1.name}"
        redirect_to @pokemon_battle
      end
    end
  end

  def surrender
    pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    pokemon1_current_experience = pokemon1.current_experience
    pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
    pokemon2_current_experience = pokemon2.current_experience
    current_turn = @pokemon_battle.current_turn
    experience_gain = PokemonBattleCalculator.calculate_experience(pokemon1.level)
    bonus = PokemonBattleCalculator.calculate_level_up_extra_state


    if current_turn % 2 == 0

      health_point = pokemon1.max_health_point + bonus.health_point
      attack_point = pokemon1.attack + bonus.attack_point
      defence_point = pokemon1.defence + bonus.defence_point
      speed_point = pokemon1.speed + bonus.speed_point
      total_exprience_pokemon_winner = pokemon1_current_experience + experience_gain
      @pokemon_battle.update(pokemon_winner_id: pokemon1.id,
                             pokemon_loser_id: pokemon2.id,
                             state: "finish",
                             experience_gain: experience_gain)
      pokemon1.update(max_health_point: health_point,
                      attack: attack_point,
                      defence: defence_point,
                      speed: speed_point,
                      current_experience: total_exprience_pokemon_winner)


      #level_up?
      level_pokemon_winner = pokemon1.level
      level_up = PokemonBattleCalculator.level_up?(level_pokemon_winner, total_exprience_pokemon_winner)

      if level_up == true
       experience_turn = total_exprience_pokemon_winner / 100
       level = Math.log2(experience_turn).to_i + 1
       pokemon1.update(level: level)
      end

      flash[:success] = "#{@pokemon_battle.pokemon1.name} Menang"
      redirect_to @pokemon_battle
    else

      health_point = pokemon2.max_health_point + bonus.health_point
      attack_point = pokemon2.attack + bonus.attack_poin
      defence_point = pokemon2.defence + bonus.defence_point
      speed_point = pokemon2.speed + bonus.speed_point
      total_exprience_pokemon_winner = pokemon2_current_experience + experience_gain
      @pokemon_battle.update(pokemon_winner_id: pokemon2.id)
      @pokemon_battle.update(pokemon_loser_id: pokemon1.id)
      @pokemon_battle.update(pokemon_winner_id: pokemon2.id,
                             pokemon_loser_id: pokemon1.id,
                             state: "finish",
                             experience_gain: experience_gain)
      pokemon2.update(max_health_point: health_point,
                      attack: attack_point,
                      defence: defence_point,
                      speed: speed_point,
                      current_experience: total_exprience_pokemon_winner)


      #level_up?
      level_pokemon_winner = pokemon2.level
      level_up = PokemonBattleCalculator.level_up?(level_pokemon_winner, total_exprience_pokemon_winner)

      if level_up == true
       experience_turn = total_exprience_pokemon_winner / 100
       level = Math.log2(experience_turn).to_i + 1
       pokemon2.update(level: level)
      end

      flash[:success] = "#{@pokemon_battle.pokemon2.name} Menang"
      redirect_to @pokemon_battle
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
