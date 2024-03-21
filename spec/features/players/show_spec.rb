require "rails_helper"

RSpec.describe "Players Show Page", type: :feature do
  describe "User Story 4" do
    # User Story 4, Child Show 

    # As a visitor
    # When I visit '/child_table_name/:id'
    # Then I see the child with that id including the child's attributes
    # (data from each column that is on the child table)
    describe "As a visitor" do
      describe "When I visit '/players/:id" do
        it "Then I see the player with that id including his attributes" do
          #arrange
          nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
          # lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
          # thunder = Team.create!(name: "Thunder", city: "Oklahoma City", single_city: true, total_cap: 160502705)
          jokic = nuggets.players.create!(name:"Nikola Jokic", age: 29, international: true)
          #act
          visit "/players/#{jokic.id}"
          #assert
          expect(page).to have_content('Name: Nikola Jokic')
          expect(page).to have_content('Age: 29')
          expect(page).to have_content('International Player: true')
          expect(page).to have_content('Team: Denver Nuggets')
        end
      end
    end
  end
end