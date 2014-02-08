class CreateIchimokus < ActiveRecord::Migration
  def change
    create_table :ichimokus do |t|
      t.references :indicator
      t.timestamp :time
      t.decimal :tenkan_sen, scale: 12, precision: 24
      t.decimal :kijun_sen, scale: 12, precision: 24
      t.decimal :chinkou_span, scale: 12, precision: 24
      t.decimal :senkou_span_a, scale: 12, precision: 24
      t.decimal :senkou_span_b, scale: 12, precision: 24
    end

    add_index :ichimokus, :time
    add_index :ichimokus, :indicator_id
  end
end
