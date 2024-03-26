require "rails_helper"

RSpec.describe "Teams Players Index Page", type: :feature do
  before :each do
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
    describe "As a visitor" do
      describe "When I visit a team's show page" do
        it "Then I see a link that takes me to the team's players page" do
          #act
          visit "/teams/#{@nuggets.id}"
          #assert
          expect(page).to have_link("Roster")
          #act
          click_on("Roster")
          #assert
          expect(page).to have_current_path("/teams/#{@nuggets.id}/players")
        end
      end
    end
  end

  describe "User Story 13" do
    describe "As a visitor" do
      describe "When I visit a Team Players Index page" do
        it "Then I see a link to add a new player to that team 'Create Player'" do
          #act
          visit "/teams/#{@nuggets.id}/players"
          #assert
          expect(page).to have_link("Create Player")
        end
      end
      
      describe "When I click the 'Create Player' link" do
        it "I am taken to '/parents/:team_id/players/new where I see the 'New Player' form" do
          #act
          visit "/teams/#{@nuggets.id}/players"
          click_on "Create Player"
          #assert
          expect(page).to have_current_path("/teams/#{@nuggets.id}/players/new")
          expect(page).to have_content("Create a new player")
          expect(page).to have_selector('form')
        end
      end

      describe "When I fill in the form with the player's attributes and click 'Create Player'" do
        it "Then a new Player record is created for that team and I am redirected to the Team Players Index page where I see the new player listed" do
          #act
          visit "/teams/#{@nuggets.id}/players/new"
          
          fill_in "name", with: "Michael Porter Jr."
          fill_in "age", with: 25
          choose("international_false")

          click_button "submit"
          #assert
          expect(page).to have_current_path("/teams/#{@nuggets.id}/players")
          expect(page).to have_content('Name: Michael Porter Jr.')
          expect(page).to have_content('Age: 25')
          expect(page).to have_content('International Player: false')
        end
      end
    end
  end

  describe "User Story 16" do
    describe "As a visitor" do
      describe "When I visit the Team's Players Index Page" do
        it "Then I see a lnk to sort children in alphabetical order" do
          #act
          visit "/teams/#{@nuggets.id}/players"
          #assert
          expect(page).to have_link("Sort Alphabetically")
        end
      end
      
      describe "When I click on the link" do
        it "I'm taken back to the Team's Players Index Page with the players in alpha order" do
          #act
          visit "/teams/#{@nuggets.id}/players"
          click_on("Sort Alphabetically")
          #assert
          expect(page).to have_current_path("/teams/#{@nuggets.id}/players?sort=alphabetically")
          expect(@murray.name).to appear_before(@jokic.name)
        end
      end
    end
  end

  describe "User Story 21" do
    describe "As a visitor" do
      describe "When I visit the Team's Players Index Page" do
        it "I see a form that allows me to input an age value" do
          #act
          visit "/teams/#{@nuggets.id}/players"
          #assert
          within "#filter_by_age" do
            expect(page).to have_selector('form')
          end
        end
      end

      describe "When I input an age and click submit on the 'Filter by Age' button" do
        it "I am brought back to the Team's Players Index Page with just the players that meet the age threshold displayed" do
          #act
          visit "/teams/#{@nuggets.id}/players"
          fill_in(:players_older_than_age, with: '28')
          click_button('Submit')
          #assert
          expect(page).to have_content("Nikola Jokic")
          expect(page).to_not have_content("Jamal Murray")
        end
      end
    end
  end
end