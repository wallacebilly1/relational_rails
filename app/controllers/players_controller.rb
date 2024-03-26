class PlayersController < ApplicationController
  def index
    @players = Player.international_only
  end

  def show
    @player = Player.find(params[:id])
  end

  def new

  end

  def create

  end

  def edit
    @player = Player.find(params[:id])
    @team = Team.find(@player.team_id)
  end

  def update 
    player = Player.find(params[:id])
    player.update!(player_params)

    redirect_to "/players/#{player.id}"
  end

  def destroy
    player = Player.find(params[:id])
    player.destroy

    redirect_to "/players"
  end

  private
  def player_params
    params.permit(:name, :age, :international, :team_id)
  end
end