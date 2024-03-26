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

    it '.sort_alpha' do
      nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
      jokic = nuggets.players.create!(name:"Nikola Jokic", age: 29, international: true)
      murray = nuggets.players.create!(name:"Jamal Murray", age: 27, international: true)
      pope = nuggets.players.create!(name:"Kentavious Caldwell-Pope", age: 31, international: false)

      expect(Player.sort_alpha).to eq [murray, pope, jokic]
    end

    it '.filter_older_than_age' do
      nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
      jokic = nuggets.players.create!(name:"Nikola Jokic", age: 29, international: true)
      murray = nuggets.players.create!(name:"Jamal Murray", age: 27, international: true)
      pope = nuggets.players.create!(name:"Kentavious Caldwell-Pope", age: 31, international: false)

      expect(Player.filter_older_than_age(25)).to eq [jokic, murray, pope]
      expect(Player.filter_older_than_age(30)).to eq [pope]
    end
  end
end