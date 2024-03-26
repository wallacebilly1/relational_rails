class TeamsController < ApplicationController
  def index
    @teams = Team.order_by_created_at
  end

  def show
    @team = Team.find(params[:id])
  end

  def new

  end

  def create
    team = Team.create!(team_params)

    redirect_to "/teams/#{team.id}"
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update 
    team = Team.find(params[:id])
    team.update!(team_params)

    redirect_to "/teams/#{team.id}"
  end

  def destroy
    team = Team.find(params[:id])
    players = team.players

    players.destroy_all
    team.destroy

    redirect_to "/teams"
  end

  private
  def team_params
    params.permit(:name, :city, :single_city, :total_cap)
  end
end