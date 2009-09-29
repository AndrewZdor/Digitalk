class CreateAdminGroupings < ActiveRecord::Migration
  def self.up
    create_table :admin_groupings do |t|
      t.integer :group_id
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :admin_groupings
  end
end
