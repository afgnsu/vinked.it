class AddCountryIdToClub < ActiveRecord::Migration
  def change
    add_column :clubs, :country_id, :integer
    add_index :clubs, :country_id
  end
end
