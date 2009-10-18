class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string    :name
      t.integer   :level
    end    
    [{ :name => "admin",   :level => 150 },
     { :name => "editor",  :level => 100 },
     { :name => "user",    :level => 50  },
     { :name => "guest",   :level => 1 }].each do |role|
       Role.create(role)
     end
  end

  def self.down
    drop_table :roles
  end
end