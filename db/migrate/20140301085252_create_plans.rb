class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :pair
      t.integer :th
      t.decimal :depo
      t.decimal :min
      t.decimal :max
      t.decimal :pr
      t.decimal :martin
      t.references :user

      t.timestamps
    end
  end
end
