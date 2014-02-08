class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.timestamp :time
      t.text :val
    end

    add_index :points, :time
  end
end
