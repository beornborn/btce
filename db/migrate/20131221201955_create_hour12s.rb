class CreateHour12s < ActiveRecord::Migration
  def change
    create_table :hour12s do |t|
      t.timestamp :time
      t.decimal :enter, scale: 12, precision: 24
      t.decimal :close, scale: 12, precision: 24
      t.decimal :min, scale: 12, precision: 24
      t.decimal :max, scale: 12, precision: 24
      t.decimal :amount, scale: 12, precision: 24
    end

    add_index :hour12s, :time
  end
end
