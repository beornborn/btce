class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.timestamp :time
      t.decimal :price, scale: 12, precision: 24
      t.decimal :amount, scale: 12, precision: 24
    end

    add_index :transactions, :time
  end
end