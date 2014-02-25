class AddFieldsToVink < ActiveRecord::Migration
  def change
    add_column :vinks, :programme_link, :string
    add_column :vinks, :ticket_link, :string
  end
end
