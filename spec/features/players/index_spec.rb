require "rails_helper"

RSpec.describe "Players Index Page", type: :feature do
  describe "User Story 3" do
    # User Story 3, Child Index 

    # As a visitor
    # When I visit '/child_table_name'
    # Then I see each Child in the system including the Child's attributes
    # (data from each column that is on the child table)
    describe "As a visitor" do
      describe "When I visit '/players'" do
        it "Then I see each player in the system including the player's attributes" do
          #arrange
          nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
          lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
          thunder = Team.create!(name: "Thunder", city: "Oklahoma City", single_city: true, total_cap: 160502705)

          jokic = Player.create!(name:"Nikola Jokic", age: 29, international: true, team_id: nuggets.id)
          murray = Player.create!(name:"Jamal Murray", age: 27, international: true, team_id: nuggets.id)
          lebron = Player.create!(name:"Lebron James", age: 39, international: false, team_id: lakers.id)
          davis = Player.create!(name:"Anthony Davis", age: 31, international: false, team_id: lakers.id)
          shai = Player.create!(name:"Shai Gilgeous-Alexander", age: 25, international: true, team_id: thunder.id)
          chet = Player.create!(name:"Chet Holmgren", age: 21, international: false, team_id: thunder.id)
          #act
          visit "/players"
          #assert
          expect(page).to have_content('Name: Nikola Jokic')
          expect(page).to have_content('Age: 29')
          expect(page).to have_content('International Player: true')
          # expect(page).to have_content('Team: Nuggets')
        end
      end
    end
  end
end