class TeamsController < ApplicationController
  def index
    # move .order to the model 
    @teams = Team.all.order(created_at: :desc)
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

  private
  def team_params
    params.permit(:name, :city, :single_city, :total_cap)
  end
end