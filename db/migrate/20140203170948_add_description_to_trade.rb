class AddDescriptionToTrade < ActiveRecord::Migration
  def change
    remove_column :trades, :description
    add_column :trades, :options, :text
  end
end
