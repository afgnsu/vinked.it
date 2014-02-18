class AddLeagueIdToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :league_id, :integer
    add_index :clubs, :league_id
  end
end
