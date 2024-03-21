require "rails_helper"

RSpec.describe "Teams Players Index Page", type: :feature do
  describe "User Story 5" do
    # User Story 5, Parent Children Index 

    # As a visitor
    # When I visit '/parents/:parent_id/child_table_name'
    # Then I see each Child that is associated with that Parent with each Child's attributes
    # (data from each column that is on the child table)
    describe "As a visitor" do
      describe "When I visit '/teams/:team_id/players" do
        it "Then I see each player that is associated with the team and their attributes" do
          #arrange
          nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
          jokic = Player.create!(name:"Nikola Jokic", age: 29, international: true, team_id: nuggets.id)
          murray = Player.create!(name:"Jamal Murray", age: 27, international: true, team_id: nuggets.id)
          #act
          visit "/teams/#{nuggets.id}/players"
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
end