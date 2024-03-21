require "rails_helper"

RSpec.describe "Teams Show Page", type: :feature do
  before :all do
    @nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
    @lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
    @thunder = Team.create!(name: "Thunder", city: "Oklahoma City", single_city: true, total_cap: 160502705)
  end

  describe "User Story 2" do
    # User Story 2, Parent Show 

    # As a visitor
    # When I visit '/parents/:id'
    # Then I see the parent with that id including the parent's attributes
    # (data from each column that is on the parent table)
    describe "As a visitor" do
      describe "When I visit '/teams/:id'" do
        it "Then I see the parent with that id, including parent's attributes" do
          #act
          visit "/teams/#{@nuggets.id}"
          #assert
          expect(page).to have_content('Name: Nuggets')
          expect(page).to have_content('City: Denver')
          expect(page).to have_content('This team has never moved: true')
          expect(page).to have_content('Total Salary Cap: 185751085')
        end
      end
    end
  end

  describe "User Story 7" do
    # User Story 7, Parent Child Count

    # As a visitor
    # When I visit a parent's show page
    # I see a count of the number of children associated with this parent
    describe "As a visitor" do
      describe "When I visit '/teams/:id" do
        it "Then I see a count of the number of players associated with this team" do
          #arrage
          @nuggets.players.create!(name:"Nikola Jokic", age: 29, international: true)
          @nuggets.players.create!(name:"Jamal Murray", age: 27, international: true)
          @lakers.players.create!(name:"Lebron James", age: 39, international: false)
          #act
          visit "/teams/#{@nuggets.id}"
          #assert
          expect(page).to have_content("Player Count: 2")
          visit "/teams/#{@lakers.id}"
          #assert
          expect(page).to have_content("Player Count: 1")
        end
      end
    end
  end
end