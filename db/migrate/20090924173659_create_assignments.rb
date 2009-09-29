class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.references :user
      t.references :entity
      t.integer :row_id
      t.integer :permission
      t.integer :assigned_by_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
