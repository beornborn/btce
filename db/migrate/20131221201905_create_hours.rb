class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.timestamp :time
      t.decimal :enter, scale: 12, precision: 24
      t.decimal :close, scale: 12, precision: 24
      t.decimal :min, scale: 12, precision: 24
      t.decimal :max, scale: 12, precision: 24
      t.decimal :amount, scale: 12, precision: 24
    end

    add_index :hours, :time
  end
end
