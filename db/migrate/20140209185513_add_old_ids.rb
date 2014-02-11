class AddOldIds < ActiveRecord::Migration
  def change
    add_column :leagues, :old_id, :integer
    add_column :clubs, :old_id, :integer
  end
end
