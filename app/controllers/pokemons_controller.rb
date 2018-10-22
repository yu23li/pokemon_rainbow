class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]
  before_action :pokedex_select, only: [:new, :edit, :update, :create]

  # GET /pokemons
  # GET /pokemons.json
  def index
    @pokemons = Pokemon.all.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /pokemons/1
  # GET /pokemons/1.json
  def show
    @pokedex = Pokedex.find(@pokemon.pokedex_id)
    @skill_select = Skill.where(element_type: @pokedex.element_type).collect{ |u| [u.name, u.id] }
    @pokemon_skill = PokemonSkill.new
    @pokemon_skills = PokemonSkill.where(pokemon_id: @pokemon.id)
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
    @pokedex ||= Pokedex.all
  end

  # GET /pokemons/1/edit
  def edit
    @pokedex ||= Pokedex.all
  end

  # POST /pokemons
  # POST /pokemons.json
  def create
    @pokemon = Pokemon.new(pokemon_params)
    pokedex = Pokedex.find(@pokemon.pokedex_id)

    #ini namanya assign
    @pokemon.level = 1
    @pokemon.current_experience = 0
    @pokemon.max_health_point = pokedex.base_health_point
    @pokemon.current_health_point = pokedex.base_health_point
    @pokemon.attack = pokedex.base_attack
    @pokemon.defence = pokedex.base_defence
    @pokemon.speed = pokedex.base_speed

     if @pokemon.save
       redirect_to @pokemon, notice: 'Pokemon was successfully created.'
     else
       render :new
     end
  end

  # PATCH/PUT /pokemons/1
  # PATCH/PUT /pokemons/1.json
  def update
     if @pokemon.update(pokemon_params)
       redirect_to @pokemon, notice: 'Pokemon was successfully updated.'
     else
       render :edit
     end
  end

  # DELETE /pokemons/1
  # DELETE /pokemons/1.json
  def destroy
    if @pokemon.destroy
      redirect_to pokemons_url, notice: 'Pokemon was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    def pokedex_select
      @pokedex_select = Pokedex.all.collect{ |u| [u.name, u.id] }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_params
      params.require(:pokemon).permit(:pokedex_id, :name, :level, :max_health_point, :current_health_point, :attack, :defence, :speed, :current_experience)
    end
end
