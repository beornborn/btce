class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.timestamp :begin
      t.timestamp :end
      t.decimal :initial_usd, scale: 12, precision: 24
      t.references :exchange
      t.references :strategy
    end
  end
end
