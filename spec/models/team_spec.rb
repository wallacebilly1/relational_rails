require "rails_helper"

RSpec.describe Team, type: :model do
  describe 'relationships' do
    it {should have_many :players}
  end

  describe 'instance methods' do
    it '#player_count' do
      nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
      nuggets.players.create!(name:"Nikola Jokic", age: 29, international: true)
      nuggets.players.create!(name:"Jamal Murray", age: 27, international: true)

      lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
      lakers.players.create!(name:"Lebron James", age: 39, international: false)

      expect(nuggets.player_count).to eq 2
      expect(lakers.player_count).to eq 1
    end
  end

  describe 'class methods' do
    it '.order_by_created_at' do
      nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
      lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)

      expect(Team.order_by_created_at).to eq [lakers, nuggets]
    end
  end
end