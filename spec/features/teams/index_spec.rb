require "rails_helper"

RSpec.describe "Teams Index Page", type: :feature do
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

  describe "User Story 1" do
    describe "As a visitor" do
      describe "When I visit '/teams'" do
        it "Then I see the name of each team record in the system" do
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

  describe "User Story 6" do
    describe "As a visitor" do
      describe "When I visit '/teams'" do
        it "Then I see the records are ordered by most recently created first" do
          #act
          visit "/teams"
          #assert
          expect("#{@thunder.name}").to appear_before("#{@nuggets.name}", only_text: true)
        end

        it "And next to each of the records I see when it was created" do
          #act
          visit "/teams"
          #assert
          expect(page).to have_content("Name: #{@nuggets.name}, Created At: #{@nuggets.created_at}")
        end
      end
    end
  end

  describe "User Story 9" do
    describe "As a visitor" do
      describe "When I visit any page on the site" do
        it "Then I see a link at the top of the page that takes me to the Team Index" do
          #act
          visit "/players"
          #assert
          expect(page).to have_link("Teams")
          #act
          visit "/teams/#{@nuggets.id}"
          #assert
          expect(page).to have_link("Teams")
        end
      end
    end
  end

  describe "User Story 11" do
    describe "As a visitor" do
      describe "When I visit the Teams Index Page" do
        it "Then  I see a link to create a new Team" do
          #act
          visit "/teams"
          #assert
          expect(page).to have_link("Create Team")
        end
      end

      describe "When I click the 'New Team' link" do
        it "Then I am taken to '/teams/new' Where I see a form for a new team" do
          #act
          visit "/teams"
          click_on("Create Team")
          #assert
          expect(page).to have_current_path("/teams/new")
          within "#create_team_form" do
            expect(page).to have_content("Create a Team")
            expect(page).to have_selector('form')
          end
        end
      end

      describe "When I fill out the form with a new team's attributes and I click the button 'Create Team'" do
        it "Then a new Team record is created and I am redirected to that Teams Index page where I see the new team displayed" do
          #act
          visit "/teams/new"

          fill_in "name", with: "Kings"
          fill_in "city", with: "Sacramento"
          choose("single_city_false")
          fill_in "total_cap", with: "149993550"

          click_button "submit"
          #assert
          expect(page).to have_current_path("/teams/#{Team.last.id}")
          expect(page).to have_content('Name: Kings')
          expect(page).to have_content('City: Sacramento')
          expect(page).to have_content('This team has never moved: false')
          expect(page).to have_content('Total Salary Cap: 149993550')
        end
      end
    end
  end
end