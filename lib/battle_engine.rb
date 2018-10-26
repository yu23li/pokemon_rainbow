class BattleEngine
  attr_reader :flash

  def initialize(pokemon_battle:, attacker:, defender:, skill_id:)
    @pokemon_battle = pokemon_battle
    @attacker = attacker
    @defender = defender
    @skill_id = skill_id
    @flash = {}
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
     @flash[:success] = "Selamat #{winner.name} memenangkan pertandingan ini!"
  end

  def attack_action(skill_id:, attacker:, defender:)
    pokemon_skill = PokemonSkill.where("skill_id = ? AND pokemon_id = ?", skill_id, attacker).first
    damage = PokemonBattleCalculator.calculate_damage(attacker, defender, skill_id)
    current_hp = defender.current_health_point - damage
    pokemon_current_hp = current_hp < 0 ? 0 : current_hp
    current_pp = pokemon_skill.current_pp - 1
    current_turn = @pokemon_battle.current_turn + 1

    if pokemon_skill.current_pp == 0
        @flash[:error] = "#{attacker.name} sudah tidak punya kekuatan!"

    else
      if pokemon_current_hp == 0
         game_finish(winner:attacker, loser:defender)
      end
      defender.update(current_health_point: pokemon_current_hp)
      pokemon_skill.update(current_pp: current_pp)
      @pokemon_battle.update(current_turn: current_turn)
      @flash[:success] = "GOOD JOB #{attacker.name}"
    end
  end

  def valid_next_turn?
    if @pokemon_battle.pokemon_winner_id == nil and @pokemon_battle.pokemon_loser_id == nil
      true
    else
      false
    end
  end

  def next_turn!
    if valid_next_turn? == true
      attack_action(skill_id: @skill_id, attacker: @attacker, defender: @defender)
    else
      save!
    end
  end

  def save!
    game_finish(winner: @attacker, loser: @defender)
  end
end