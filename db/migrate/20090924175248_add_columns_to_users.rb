class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :isGroup, :boolean
    add_column :users, :isAdmin, :boolean
  end

  def self.down
    remove_column :users, :isGroup
    remove_column :users, :isAdmin
  end
end
