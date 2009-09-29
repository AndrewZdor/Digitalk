class CreateProjectUsers < ActiveRecord::Migration
  def self.up
    create_table :project_users do |t|
      t.references :Project
      t.references :User
      t.references :ProjectGroup

      t.timestamps
    end
  end

  def self.down
    drop_table :project_users
  end
end
