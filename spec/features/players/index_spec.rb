require "rails_helper"

RSpec.describe "Players Index Page", type: :feature do
  before :all do
    @nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
    @lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
    @thunder = Team.create!(name: "Thunder", city: "Oklahoma City", single_city: true, total_cap: 160502705)

    @jokic = @nuggets.players.create!(name:"Nikola Jokic", age: 29, international: true)
    @murray = @nuggets.players.create!(name:"Jamal Murray", age: 27, international: true)
    @lebron = @lakers.players.create!(name:"Lebron James", age: 39, international: false)
    @davis = @lakers.players.create!(name:"Anthony Davis", age: 31, international: false)
    @shai = @thunder.players.create!(name:"Shai Gilgeous-Alexander", age: 25, international: true)
    @chet = @thunder.players.create!(name:"Chet Holmgren", age: 21, international: false)
  end
  
  describe "User Story 3" do
    describe "As a visitor" do
      describe "When I visit '/players'" do
        it "Then I see each player in the system including the player's attributes" do
          #act
          visit "/players"
          #assert
          expect(page).to have_content('Name: Nikola Jokic')
          expect(page).to have_content('Age: 29')
          expect(page).to have_content('International Player: true')
          expect(page).to have_content('Team: Nuggets')
        end
      end
    end
  end

  describe "User Story 8" do
    describe "As a visitor" do
      describe "When I visit any page on the site" do
        it "Then I see a link at the top of the page that takes me to the Players Index" do
          #act
          visit "/teams"
          #assert
          expect(page).to have_link("Players")
          #act
          visit "/teams/#{@nuggets.id}"
          #assert
          expect(page).to have_link("Players")
        end
      end
    end
  end

  describe "User Story 15" do
    # User Story 15, Child Index only shows `true` Records 

    # As a visitor
    # When I visit the child index
    # Then I only see records where the boolean column is `true`
    describe "As a visitor" do
      describe "When I visit the player index" do
        it "Then I only see records of international players" do
          #act
          visit "/players"
          #assert
          expect(page).to have_content('Name: Nikola Jokic')
          expect(page).to have_content('Name: Jamal Murray')
          expect(page).to have_content('Name: Shai Gilgeous-Alexander')
        end
      end
    end
  end
end