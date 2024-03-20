require "rails_helper"

RSpec.describe "Teams Index Page", type: :feature do
  describe "User Story 1" do
    # User Story 1, Parent Index 

    # For each parent table
    # As a visitor
    # When I visit '/parents'
    # Then I see the name of each parent record in the system
    describe "As a visitor" do
      describe "When I visit '/teams'" do
        it "Then I see the name of each team record in the system" do
          #arrange
          nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
          lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
          thunder = Team.create!(name: "Thunder", city: "Oklahoma City", single_city: true, total_cap: 160502705)
          #act
          visit "/teams"
          #assert
          expect(page).to have_content('Name: Nuggets')
          expect(page).to have_content('Name: Lakers')
          expect(page).to have_content('Name: Thunder')
        end
      end
    end
  end
end