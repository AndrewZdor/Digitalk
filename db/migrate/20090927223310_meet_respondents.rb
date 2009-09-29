class MeetRespondents < ActiveRecord::Migration

  def self.up
    drop_table :project_users

    change_table :admin_groupings do |t|
      t.references :project
      t.references :project_group
    end
    rename_table :admin_groupings, :user_groupings
  end

  def self.down
    create_table "project_users", :force => true do |t|
      t.integer  "Project_id"
      t.integer  "User_id"
      t.integer  "ProjectGroup_id"
      t.timestamps
    end

    change_table :admin_groupings do |t|
      t.remove :project_id
      t.remove :project_group_id
    end
    rename_table :user_groupings, :admin_groupings
  end

end
