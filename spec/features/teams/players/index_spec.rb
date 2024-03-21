require "rails_helper"

RSpec.describe "Teams Players Index Page", type: :feature do
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
  
  describe "User Story 5" do
    # User Story 5, Parent Children Index 

    # As a visitor
    # When I visit '/parents/:parent_id/child_table_name'
    # Then I see each Child that is associated with that Parent with each Child's attributes
    # (data from each column that is on the child table)
    describe "As a visitor" do
      describe "When I visit '/teams/:team_id/players" do
        it "Then I see each player that is associated with the team and their attributes" do
          #act
          visit "/teams/#{@nuggets.id}/players"
          #assert
          expect(page).to have_content('Denver Nuggets Players')
          expect(page).to have_content('Name: Nikola Jokic')
          expect(page).to have_content('Age: 29')
          expect(page).to have_content('International Player: true')
          expect(page).to have_content('Name: Jamal Murray')
          expect(page).to have_content('Age: 27')
          expect(page).to have_content('International Player: true')
        end
      end
    end
  end

  describe "User Story 10" do
    # User Story 10, Parent Child Index Link

    # As a visitor
    # When I visit a Team show page ('/teams/:id')
    # Then I see a link that takes me to that team's players page ('teams/:id/players)
    describe "As a visitor" do
      describe "When I visit a team's show page" do
        it "Then I see a link that takes me to the team's players page" do
          #act
          visit "/teams/#{@nuggets.id}"
          #assert
          expect(page).to have_link("Roster", href: "/teams/#{@nuggets.id}/players")
          #act
          visit "/teams/#{@lakers.id}"
          #assert
          expect(page).to have_link("Roster", href: "/teams/#{@lakers.id}/players")
        end
      end
    end
  end
end