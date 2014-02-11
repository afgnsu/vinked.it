class MoveLocationFields < ActiveRecord::Migration
  def change
    add_column :clubs, :latitude, :float
    add_column :clubs, :longitude, :float
    add_column :clubs, :gmaps, :boolean
    add_column :vinks, :league_id, :integer
    remove_column :vinks, :latitude, :float
    remove_column :vinks, :longitude, :float
    remove_column :vinks, :gmaps, :boolean
  end
end
