class DefaultUserNotInGroup < ActiveRecord::Migration
  def self.up
    change_column_default(:users, :isGroup, false)
  end

  def self.down
  end
end
