class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.string :name
      t.decimal :comission, scale: 5, precision: 10
    end
  end
end
