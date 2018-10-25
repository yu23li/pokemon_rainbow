class PokemonBattleCalculator

  WEAKNESS_RESISTANCE_HASH = {:normal => {:normal => 1, :fight => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 0.5,
                                        :bug => 1, :ghost => 0, :steel => 0.5, :fire => 1, :water => 1, :grass => 1,
                                        :electr => 1, :psychc => 1, :ice => 1, :dragon => 1, :dark => 1, :fairy => 1},
                            :fight => { :normal => 2, :fight => 1, :flying => 0.5, :poison => 0.5, :ground => 1, :rock => 2,
                                        :bug => 0.5, :ghost => 0, :steel => 2, :fire => 1, :water => 1, :grass => 1,
                                        :electr => 1, :psychc => 0.5, :ice => 2, :dragon => 1, :dark => 2, :fairy => 0.5},
                            :flying => {:normal => 1, :fight => 2, :flying => 1, :poison => 1, :ground => 1, :rock => 0.5,
                                        :bug => 2, :ghost => 1, :steel => 0.5, :fire => 1, :water => 1, :grass => 2,
                                        :electr => 0.5, :psychc => 1, :ice => 1, :dragon => 1, :dark => 1, :fairy => 1},
                            :poison => {:normal => 1, :fight => 1, :flying => 1, :poison => 0.5, :ground => 0.5, :rock => 0.5,
                                        :bug => 1, :ghost => 0.5, :steel => 0, :fire => 1, :water => 1, :grass => 2,
                                        :electr => 1, :psychc => 1, :ice => 1, :dragon => 1, :dark => 1, :fairy => 2},
                            :ground => { :normal => 1, :fight => 1, :flying => 0, :poison => 2, :ground => 1, :rock => 2,
                                        :bug => 0.5, :ghost => 1, :steel => 2, :fire => 2, :water => 1, :grass => 0.5,
                                        :electr => 2, :psychc => 1, :ice => 1, :dragon => 1, :dark => 1, :fairy => 1},
                            :rock => {:normal => 1, :fight => 0.5, :flying => 2, :poison => 1, :ground => 0.5, :rock => 1,
                                      :bug => 2, :ghost => 1, :steel => 0.5, :fire => 2, :water => 1, :grass => 1,
                                      :electr => 1, :psychc => 1, :ice => 2, :dragon => 1, :dark => 1, :fairy => 1},
                            :bug => {:normal => 1, :fight => 0.5, :flying => 0.5, :poison => 0.5, :ground => 1, :rock => 1,
                                     :bug => 1, :ghost => 0.5, :steel => 0.5, :fire => 0.5, :water => 1, :grass => 2,
                                     :electr => 1, :psychc => 2, :ice => 1, :dragon => 1, :dark => 2, :fairy => 0.5},
                            :ghost => {:normal => 0, :fight => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 1,
                                       :bug => 1, :ghost => 2, :steel => 1, :fire => 1, :water => 1, :grass => 1,
                                       :electr => 1, :psychc => 2, :ice => 1, :dragon => 1, :dark => 0.5, :fairy => 1},
                            :steel => {:normal => 1, :fight => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 2,
                                       :bug => 1, :ghost => 1, :steel => 0.5, :fire => 0.5, :water => 0.5, :grass => 1,
                                       :electr => 0.5, :psychc => 1, :ice => 2, :dragon => 1, :dark => 1, :fairy => 2},
                            :fire => {:normal => 1, :fight => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 0.5,
                                      :bug => 2, :ghost => 1, :steel => 2, :fire => 0.5, :water => 0.5, :grass => 2,
                                      :electr => 1, :psychc => 1, :ice => 2, :dragon => 0.5, :dark => 1, :fairy => 1},
                            :water => {:normal => 1, :fight => 1, :flying => 1, :poison => 1, :ground => 2, :rock => 2,
                                       :bug => 1, :ghost => 1, :steel => 1, :fire => 2, :water => 0.5, :grass => 0.5,
                                       :electr => 1, :psychc => 1, :ice => 1, :dragon => 0.5, :dark => 1, :fairy => 1},
                            :grass => {:normal => 1, :fight => 1, :flying => 0.5, :poison => 0.5, :ground => 2, :rock => 2,
                                       :bug => 0.5, :ghost => 1, :steel => 0.5, :fire => 0.5, :water => 2, :grass => 0.5,
                                       :electr => 1, :psychc => 1, :ice => 1, :dragon => 0.5, :dark => 1, :fairy => 1},
                            :electr => {:normal => 1, :fight => 1, :flying => 2, :poison => 1, :ground => 0, :rock => 1,
                                        :bug => 1, :ghost => 1, :steel => 1, :fire => 1, :water => 2, :grass => 0.5,
                                        :electr => 0.5, :psychc => 1, :ice => 1, :dragon => 0.5, :dark => 1, :fairy => 1},
                            :psychc => {:normal => 1, :fight => 2, :flying => 1, :poison => 2, :ground => 1, :rock => 1,
                                        :bug => 1, :ghost => 1, :steel => 0.5, :fire => 1, :water => 1, :grass => 1,
                                        :electr => 1, :psychc => 0.5, :ice => 1, :dragon => 1, :dark => 0, :fairy => 1},
                            :ice => {:normal => 1, :fight => 1, :flying => 2, :poison => 1, :ground => 2, :rock => 1,
                                     :bug => 1, :ghost => 1, :steel => 0.5, :fire => 0.5, :water => 0.5, :grass => 2,
                                     :electr => 1, :psychc => 1, :ice => 0.5, :dragon => 2, :dark => 1, :fairy => 1},
                            :dragon => {:normal => 1, :fight => 1, :flying => 1, :poison => 1, :ground => 1, :rock => 1,
                                        :bug => 1, :ghost => 1, :steel => 0.5, :fire => 1, :water => 1, :grass => 1,
                                        :electr => 1, :psychc => 1, :ice => 1, :dragon => 2, :dark => 1, :fairy => 0},
                            :dark => {:normal => 1, :fight => 0.5, :flying => 1, :poison => 1, :ground => 1, :rock => 1,
                                      :bug => 1, :ghost => 2, :steel => 1, :fire => 1, :water => 1, :grass => 1,
                                      :electr => 1, :psychc => 2, :ice => 1, :dragon => 1, :dark => 0.5, :fairy => 0.5},
                            :fairy => {:normal => 1, :fight => 2, :flying => 1, :poison => 0.5, :ground => 1, :rock => 1,
                                       :bug => 1, :ghost => 1, :steel => 0.5, :fire => 0.5, :water => 1, :grass => 1,
                                       :electr => 1, :psychc => 1, :ice => 1, :dragon => 2, :dark => 2, :fairy => 1}}

  def self.calculate_damage(attacker_pokemon, defender_pokemon, skill_id)

    #mendapatkan nilai skill
    skill = Skill.find(skill_id)
    skill_power = skill.power
    skill_element_type = skill.element_type
    pokemon_element_type = attacker_pokemon.pokedex.element_type

    #stab
    if pokemon_element_type == skill_element_type
      stab = 1.5
    else
      stab = 1
    end

    #menghitung weakness/resistance
    element_type_attack = attacker_pokemon.pokedex.element_type.downcase.to_sym
    element_type_skill = skill_element_type.downcase.to_sym
    weakness_resistance = WEAKNESS_RESISTANCE_HASH[element_type_attack][element_type_skill]

    #damage
    damage = ((((2.0 * attacker_pokemon.level.to_f / 5.0 + 2.0) * attacker_pokemon.attack.to_f * skill_power.to_f / defender_pokemon.defence.to_f) /
              50.0) + 2.0) * stab.to_f * weakness_resistance.to_f * (rand(85.0..100.0)/100.0).to_f
    result = damage.round
  end

  def self.calculate_experience(level_pokemon_enemy)
    experience_gain = rand(20..150) * level_pokemon_enemy
  end

  def self.level_up?(level_pokemon_winner, total_exprience_pokemon_winner)
    level_limit = 2 ** level_pokemon_winner * 100

    if total_exprience_pokemon_winner < level_limit
      false
    else
      true
    end
  end

  def self.calculate_level_up_extra_state
    health_point = rand(10..20)
    attack_point = rand(1..5)
    defence_point = rand(1..5)
    speed_point = rand(1..5)

    bonus = Struct.new(:health_point, :attack_point, :defence_point, :speed_point)
    bonus.new(health_point, attack_point, defence_point, speed_point)
  end

end