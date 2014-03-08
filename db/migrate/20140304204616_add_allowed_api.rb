class AddAllowedApi < ActiveRecord::Migration
  def change
    add_column :users, :api_allowed, :boolean, default: true
  end
end
