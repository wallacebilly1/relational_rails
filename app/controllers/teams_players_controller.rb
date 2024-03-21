class TeamsPlayersController < ApplicationController
  def index
    @team = Team.find(params[:id])
    # @team_players = @team.players
  end
end