class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :city
      t.boolean :single_city
      t.integer :total_cap

      t.timestamps
    end
  end
end
