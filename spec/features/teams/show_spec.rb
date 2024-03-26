require "rails_helper"

RSpec.describe "Teams Show Page", type: :feature do
  before :each do
    @nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
    @lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
    @thunder = Team.create!(name: "Thunder", city: "Oklahoma City", single_city: true, total_cap: 160502705)
  end

  describe "User Story 2" do
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

  describe "User Story 12" do
    describe "As a visitor" do
      describe "When I visit a '/teams/:id'" do
        it "Then I see a link to update that team" do
          #act 
          visit "/teams/#{@nuggets.id}"
          #assert
          expect(page).to have_link('Update Team')
        end
      end

      describe "When I click the link 'Update Team'" do
        it "Then I am taken to '/teams/:id/edit'" do
          #act
          visit "/teams/#{@nuggets.id}"
          click_on("Update Team")
          #assert
          expect(page).to have_current_path("/teams/#{@nuggets.id}/edit")
        end

        it "Where I see a form to edit the team's attributes" do
          #act
          visit "/teams/#{@nuggets.id}/edit"
          #assert
          within "#edit_team_form" do
            expect(page).to have_selector('form')
          end
        end
      end

      describe "When I fill out the form with updated information and click the button to submit the form" do
        it "Then the team record is updated and I am redirected to the teams page where I see the updated info" do
          #act
          visit "/teams/#{@nuggets.id}/edit"
          #assert
          expect(@nuggets.name).to eq "Nuggets"
          expect(@nuggets.city).to eq "Denver"
          expect(@nuggets.single_city).to eq true
          expect(@nuggets.total_cap).to eq 185751085
          #act
          fill_in "name", with: "Dinos"
          fill_in "city", with: "Colorado"
          choose("single_city_false")
          fill_in "total_cap", with: "123123"

          click_button "submit"
          #assert
          expect(page).to have_current_path("/teams/#{@nuggets.id}")
          expect(page).to have_content('Name: Dinos')
          expect(page).to have_content('City: Colorado')
          expect(page).to have_content('This team has never moved: false')
          expect(page).to have_content('Total Salary Cap: 123123')
        end
      end
    end
  end

  describe "User Story 19" do
    describe "As a visitor" do
      describe "When I visit a team show page" do
        it "Then I see a link to delete the team" do
          #act
          visit "/teams/#{@lakers.id}"
          #assert
          expect(page).to have_button('Delete Team')
        end
      end

      describe "When I click the link 'Delete Team'" do
        it "Then I am redirected to the teams index page where I no longer see this team" do
          #act
          visit "/teams/#{@lakers.id}"
          click_button('Delete Team')
          #assert
          expect(page).to have_current_path("/teams")
          expect(page).to_not have_content("Lakers")
        end

        it "And all players from that team are deleted" do
          #act
          visit "/teams/#{@lakers.id}"
          click_button('Delete Team')
          visit "/players"
          #assert
          expect(page).to_not have_content("Lebron James")
        end
      end
    end
  end
end