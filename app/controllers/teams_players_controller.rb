class TeamsPlayersController < ApplicationController
  def index
    @team = Team.find(params[:id])
    @players = @team.players
  end

  def new
    @team = Team.find(params[:id])
  end

  def create
    team = Team.find(params[:id])
    player = Player.create!(player_params)
  end

  private
  def player_params
    params.permit(:name, :age, :international, :team_id)
  end
end