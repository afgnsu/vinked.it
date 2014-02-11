class CreateVinks < ActiveRecord::Migration
  def change
    create_table :vinks do |t|
      t.integer :vink_nr
      t.datetime :vink_date
      t.string :ground
      t.string :street
      t.string :city
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.string :result
      t.string :season
      t.string :kickoff
      t.integer :gate
      t.decimal :ticket
      t.boolean :countfor92
      t.integer :rating
      t.integer :club_id
      t.integer :away_club_id
      t.integer :user_id

      t.timestamps
    end
    add_index :vinks, :club_id
    add_index :vinks, :away_club_id
    add_index :vinks, :user_id
  end
end
