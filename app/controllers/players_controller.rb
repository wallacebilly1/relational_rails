class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new

  end

  def create
    @team = Team.find(params[:id])
    song = Song.create!(song_params)
    redirect_to "/teams/#{@team.id}/players"
  end

  private
  def player_params
    params.permit(:name, :age, :international, :team_id)
  end
end