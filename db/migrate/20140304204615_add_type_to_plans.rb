class AddTypeToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :type, :string
    add_column :orders, :buy_price, :decimal
  end
end
