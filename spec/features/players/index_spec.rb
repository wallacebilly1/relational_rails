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
    # User Story 3, Child Index 

    # As a visitor
    # When I visit '/child_table_name'
    # Then I see each Child in the system including the Child's attributes
    # (data from each column that is on the child table)
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
    # User Story 8, Child Index Link

    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Child Index
    describe "As a visitor" do
      describe "When I visit any page on the site" do
        it "Then I see a link at the top of the page that takes me to the Players Index" do
          #act
          visit "/teams"
          #assert
          expect(page).to have_link('Players', href: '/players')
          #act
          visit "/teams/#{@nuggets.id}"
          #assert
          expect(page).to have_link('Players', href: '/players')
        end
      end
    end
  end
end