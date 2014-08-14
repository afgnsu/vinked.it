class AddLocationsToVisit < ActiveRecord::Migration
  def change
    add_column :vinks, :latitude, :float
    add_column :vinks, :longitude, :float
    remove_column :clubs, :latitude, :float
    remove_column :clubs, :longitude, :float
  end
end
