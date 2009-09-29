class MiscRename < ActiveRecord::Migration
  def self.up
    rename_column :user_groupings, :group_id, :group_user_id
  end

  def self.down
    rename_column :user_groupings, :group_user_id, :group_id
  end
end
