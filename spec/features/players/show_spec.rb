require "rails_helper"

RSpec.describe "Players Show Page", type: :feature do
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
  describe "User Story 4" do
    describe "As a visitor" do
      describe "When I visit '/players/:id" do
        it "Then I see the player with that id including his attributes" do
          #act
          visit "/players/#{@jokic.id}"
          #assert
          expect(page).to have_content('Name: Nikola Jokic')
          expect(page).to have_content('Age: 29')
          expect(page).to have_content('International Player: true')
          expect(page).to have_content('Team: Denver Nuggets')
        end
      end
    end
  end

  describe "User Story 14" do
    describe "As a visitor" do
      describe "When I visit '/players/:id'" do
        it "Then I see a link to update that player" do
          #act 
          visit "/players/#{@jokic.id}"
          #assert
          expect(page).to have_link('Update Player')
        end
      end

      describe "When I click the link 'Update Player'" do
        it "I am taken to '/players/:id/edit' where I see a form to edit the player's attributes" do
          #act
          visit "/players/#{@jokic.id}"
          click_on("Update Player")
          #assert
          expect(page).to have_current_path("/players/#{@jokic.id}/edit")
          within "#edit_player_form" do
            expect(page).to have_selector('form')
          end
        end
      end

      describe "When I click the button to submit the form" do
        it "Then the player's data is updated and I am redirected to the Player's show page where I see the updated information" do
          #act
          visit "/players/#{@jokic.id}/edit"
          #assert
          expect(@jokic.name).to eq "Nikola Jokic"
          expect(@jokic.age).to eq 29
          expect(@jokic.international).to eq true
          #act
          fill_in "name", with: "Aaron Gordon"
          fill_in "age", with: "28"
          choose("international_false")

          click_button "Submit"
          #assert
          expect(page).to have_current_path("/players/#{@jokic.id}")
          expect(page).to have_content('Name: Aaron Gordon')
          expect(page).to have_content('Age: 28')
          expect(page).to have_content('International Player: false')
        end
      end
    end
  end
end