class TeamsController < ApplicationController
  def index
    @teams = Team.all.order(created_at: :desc)
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
  end

  def create
    team = Team.new({
      name: params[:name],
      city: params[:city],
      single_city: params[:single_city],
      total_cap: params[:total_cap].to_i
    })

    team.save

    redirect_to "/teams/#{team.id}"
  end
end