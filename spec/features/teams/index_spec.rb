require "rails_helper"

RSpec.describe "Teams Index Page", type: :feature do
  before :each do
    @nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
    @lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
    @thunder = Team.create!(name: "Thunder", city: "Oklahoma City", single_city: true, total_cap: 160502705)
  end
  describe "User Story 1" do
    # User Story 1, Parent Index 

    # For each parent table
    # As a visitor
    # When I visit '/parents'
    # Then I see the name of each parent record in the system
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
    # User Story 6, Parent Index sorted by Most Recently Created 

    # As a visitor
    # When I visit the parent index,
    # I see that records are ordered by most recently created first
    # And next to each of the records I see when it was created
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
end