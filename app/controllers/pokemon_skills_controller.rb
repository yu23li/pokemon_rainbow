class PokemonSkillsController < ApplicationController
  before_action :set_pokemon_skill, only: [:destroy]

  def create
    @pokemon_skill = PokemonSkill.new(pokemon_skill_params)
    skill = Skill.find(@pokemon_skill.skill_id)

    @pokemon_skill.current_pp = skill.max_pp

    respond_to do |format|
      @pokemon_skill.save
        format.html { redirect_to pokemon_url(@pokemon_skill.pokemon_id), notice: 'Pokemon was successfully created.' }
        format.json { render :show, status: :created, location: @pokemon }
    end
  end

  def destroy
   @pokemon_skill.destroy
   respond_to do |format|
     format.html { redirect_to pokemon_url(@pokemon_skill.pokemon_id), notice: 'Pokemon Skill was successfully destroyed.' }
     format.json { head :no_content }
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
