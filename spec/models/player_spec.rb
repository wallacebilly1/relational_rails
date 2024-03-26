require "rails_helper"

RSpec.describe Player, type: :model do
  describe 'relationships' do
    it {should belong_to :team}
  end

  describe 'class methods' do
    it '.international_only' do
      nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
      jokic = nuggets.players.create!(name:"Nikola Jokic", age: 29, international: true)
      murray = nuggets.players.create!(name:"Jamal Murray", age: 27, international: true)
      pope = nuggets.players.create!(name:"Kentavious Caldwell-Pope", age: 31, international: false)

      expect(Player.international_only).to eq [jokic, murray]
    end
  end
end