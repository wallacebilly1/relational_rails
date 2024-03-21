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

  describe "User Story 9" do
    # User Story 9, Parent Index Link

    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Parent Index
    describe "As a visitor" do
      describe "When I visit any page on the site" do
        it "Then I see a link at the top of the page that takes me to the Team Index" do
          #act
          visit "/players"
          #assert
          expect(page).to have_link('Teams', href: '/teams')
          #act
          visit "/teams/#{@nuggets.id}"
          #assert
          expect(page).to have_link('Teams', href: '/teams')
        end
      end
    end
  end
end