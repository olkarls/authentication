class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :email
      t.integer :role_id
      t.string  :crypted_password
      t.string  :password_salt
      t.string  :persistence_token
      t.string  :perishable_token
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end