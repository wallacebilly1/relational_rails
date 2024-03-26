class TeamsPlayersController < ApplicationController
  def index
    @team = Team.find(params[:id])
    @players = @team.players
    
    if params[:sort] == 'alphabetically'
      @players = @team.players.order(:name)
    end
  end

  def new
    @team = Team.find(params[:id])
  end

  def create
    team = Team.find(params[:id])
    player = Player.create!(player_params)

    redirect_to "/teams/#{team.id}/players" 
  end

  private
  def player_params
    params.permit(:name, :age, :international, :team_id)
  end
end