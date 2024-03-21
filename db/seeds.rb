# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

nuggets = Team.create!(name: "Nuggets", city: "Denver", single_city: true, total_cap: 185751085)
lakers = Team.create!(name: "Lakers", city: "Los Angeles", single_city: false, total_cap: 182033999)
thunder = Team.create!(name: "Thunder", city: "Oklahoma City", single_city: true, total_cap: 160502705)

jokic = Player.create!(name:"Nikola Jokic", age: 29, international: true, team_id: nuggets.id)
murray = Player.create!(name:"Jamal Murray", age: 27, international: true, team_id: nuggets.id)
lebron = Player.create!(name:"Lebron James", age: 39, international: false, team_id: lakers.id)
davis = Player.create!(name:"Anthony Davis", age: 31, international: false, team_id: lakers.id)
shai = Player.create!(name:"Shai Gilgeous-Alexander", age: 25, international: true, team_id: thunder.id)
chet = Player.create!(name:"Chet Holmgren", age: 21, international: false, team_id: thunder.id)