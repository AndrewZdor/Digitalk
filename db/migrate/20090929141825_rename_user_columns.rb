class RenameUserColumns < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.rename :isGroup, :is_group
      t.rename :isAdmin, :is_admin
    end
  end

  def self.down
    change_table :users do |t|
      t.rename :is_group, :isGroup
      t.rename :is_admin, :isAdmin
    end
  end
end
