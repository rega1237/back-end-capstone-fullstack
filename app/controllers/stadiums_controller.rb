class StadiumsController < ApplicationController
  before_action :set_stadium, only: [:show, :destroy]

  def index
    @stadiums = Stadium.all
    render json: @stadiums, status: :ok
  end

  def show
    @games = Game.where(stadium_id: @stadium.id)
    render json: {all_data: {stadium: @stadium, games: @games}}
  end

  def create
    @stadium = Stadium.new(stadium_params)
    if @stadium.save
      render json: @stadium, status: :created
    else
      render json: @stadium.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @stadium.destroy
    render json: @stadium, status: :ok
  end 

  private

  def stadium_params
    params.require(:stadium).permit(:name, :county, :seats)
  end

  def set_stadium
    @stadium = Stadium.find(params[:id])
  end
end