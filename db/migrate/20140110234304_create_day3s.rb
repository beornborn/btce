class CreateDay3s < ActiveRecord::Migration
  def change
    create_table :day3s do |t|
      t.timestamp :time
      t.decimal :open, scale: 12, precision: 24
      t.decimal :high, scale: 12, precision: 24
      t.decimal :low, scale: 12, precision: 24
      t.decimal :close, scale: 12, precision: 24
      t.decimal :amount, scale: 12, precision: 24
      t.decimal :tramount, scale: 12, precision: 24
    end

    add_index :day3s, :time
  end
end
