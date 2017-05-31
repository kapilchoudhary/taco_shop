class TacosController < ApplicationController  
  before_action :set_taco, only: [:show, :update, :destroy]

  # GET /tacos
  def index
    @tacos = Taco.all
    json_response(@tacos)
  end

  # POST /tacos
  def create
    @taco = Taco.create!(taco_params)
    json_response(@taco, :created)
  end

  # GET /tacos/:id
  def show
    json_response(@taco)
  end

  # PUT /tacos/:id
  def update
    @taco.update(taco_params)
    head :no_content
  end

  # DELETE /tacos/:id
  def destroy
    @taco.destroy
    head :no_content
  end

  private

  def taco_params
    # whitelist params
    params.require(:taco).permit(:meat, :rice, :salsa, :other_side, :notes)
  end

  def set_taco
    @taco = Taco.find(params[:id])
  end
end
