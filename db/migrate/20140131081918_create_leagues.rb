class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string  :name
      t.integer :level
      t.integer :country_id

      t.timestamps
    end
    add_index :leagues, :country_id
  end
end
