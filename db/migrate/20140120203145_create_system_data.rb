class CreateSystemData < ActiveRecord::Migration
  def change
    create_table :system_data do |t|
      t.string :name
      t.text :val
    end
  end
end
