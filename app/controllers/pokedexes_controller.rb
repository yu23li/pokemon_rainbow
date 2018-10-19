class PokedexesController < ApplicationController
  before_action :set_pokedex, only: [:show, :edit, :update, :destroy]
  before_action :element_type_select, only: [:new, :create, :edit, :update]

  # GET /pokedexes
  # GET /pokedexes.json
  def index
    @pokedexes = Pokedex.all.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /pokedexes/1
  # GET /pokedexes/1.json
  def show
  end

  # GET /pokedexes/new
  def new
    @pokedex = Pokedex.new
  end

  # GET /pokedexes/1/edit
  def edit
  end

  # POST /pokedexes
  # POST /pokedexes.json
  def create
    @pokedex = Pokedex.new(pokedex_params)
    if @pokedex.save
      redirect_to @pokedex, notice: 'Pokedex was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pokedexes/1
  # PATCH/PUT /pokedexes/1.json
  def update
    respond_to do |format|
      if @pokedex.update(pokedex_params)
        format.html { redirect_to @pokedex, notice: 'Pokedex was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokedex }
      else
        format.html { render :edit }
        format.json { render json: @pokedex.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokedexes/1
  # DELETE /pokedexes/1.json
  def destroy
    @pokedex.destroy
    respond_to do |format|
      format.html { redirect_to pokedexes_url, notice: 'Pokedex was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokedex
      @pokedex = Pokedex.find(params[:id])
    end

    def element_type_select
      @element_type_select = Pokedex::ELEMENT_TYPE.collect{ |u| [u, u] }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokedex_params
      params.require(:pokedex).permit(:name, :base_health_point, :base_attack, :base_defence, :base_speed, :element_type, :image_url)
    end
end
