class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :plan
      t.references :user
      t.integer :btce_id
      t.string :pair
      t.string :type
      t.decimal :amount
      t.decimal :rate
      t.timestamp :timestamp_created
      t.string :status
      t.decimal :spent_usd
      t.decimal :sell_price
      t.string :state

      t.timestamps
    end
  end
end
