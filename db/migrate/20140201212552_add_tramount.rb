class AddTramount < ActiveRecord::Migration
  def change
    add_column :minutes, :tramount, :decimal, scale: 12, precision: 24
    add_column :minute3s, :tramount, :decimal, scale: 12, precision: 24
    add_column :minute5s, :tramount, :decimal, scale: 12, precision: 24
    add_column :minute15s, :tramount, :decimal, scale: 12, precision: 24
    add_column :minute30s, :tramount, :decimal, scale: 12, precision: 24
    add_column :hours, :tramount, :decimal, scale: 12, precision: 24
    add_column :hour2s, :tramount, :decimal, scale: 12, precision: 24
    add_column :hour4s, :tramount, :decimal, scale: 12, precision: 24
    add_column :hour6s, :tramount, :decimal, scale: 12, precision: 24
    add_column :hour12s, :tramount, :decimal, scale: 12, precision: 24
    add_column :days, :tramount, :decimal, scale: 12, precision: 24
    add_column :day3s, :tramount, :decimal, scale: 12, precision: 24
    add_column :day7s, :tramount, :decimal, scale: 12, precision: 24
  end
end