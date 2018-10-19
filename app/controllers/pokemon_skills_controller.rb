class PokemonSkillsController < ApplicationController
  before_action :set_pokemon_skill, only: [:destroy]

  def create
    @pokemon_skill = PokemonSkill.new(pokemon_skill_params)
    skill = Skill.find(@pokemon_skill.skill_id)

    @pokemon_skill.current_pp = skill.max_pp
    if @pokemon_skill.save
      redirect_to pokemon_url(@pokemon_skill.pokemon_id), notice: 'Pokemon was successfully created.'
    else
      redirect_to pokemon_url(@pokemon_skill.pokemon_id), notice: @pokemon_skill.errors.full_messages.join('<br>')
    end
  end

  def destroy
   if @pokemon_skill.destroy
      redirect_to pokemon_url(@pokemon_skill.pokemon_id), notice: 'Pokemon Skill was successfully destroyed.'
    end
  end

  def pokemon_skill_params
    params.require(:pokemon_skill).permit(:skill_id, :pokemon_id, :current_pp)
  end

  private

  def set_pokemon_skill
    @pokemon_skill = PokemonSkill.find(params[:id])
  end
end
