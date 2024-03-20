require "rails_helper"

RSpec.describe "Teams Show Page", type: :feature do
  describe "User Story 2" do
    # User Story 2, Parent Show 

    # As a visitor
    # When I visit '/parents/:id'
    # Then I see the parent with that id including the parent's attributes
    # (data from each column that is on the parent table)
    describe "As a visitor" do
      describe "When I visit '/teams/:id'" do
        it "Then I see the parent with that id, including parent's attributes" do
          #arrange
          nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
          lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
          thunder = Team.create!(name: "Thunder", city: "Oklahoma City", single_city: true, total_cap: 160502705)
          #act
          visit "/teams/#{nuggets.id}"
          #assert
          expect(page).to have_content('Name: Nuggets')
          expect(page).to have_content('City: Denver')
          expect(page).to have_content('This team has never moved: true')
          expect(page).to have_content('Total Salary Cap: 185751085')
        end
      end
    end
  end
end