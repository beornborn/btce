class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.string :btce_key
      t.string :btce_secret
      t.integer :nonce, default: 1
      t.boolean :api_allowed, default: false

      t.timestamps
    end
  end
end
