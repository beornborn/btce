class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
      t.string :name
      t.text :options
      t.string :options_hash
    end
  end
end
