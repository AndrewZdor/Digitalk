class RemoveOdds < ActiveRecord::Migration
  def self.up
    remove_column :users, :level

    drop_table :ownerships

    drop_table :roles

    # Make column names more self-descriptive.
    change_table :assignments do |t|
      t.rename :row_id, :subject_id
      t.rename :permission, :permission_mask
    end
  end

  def self.down
    add_column :users, :level, :string

    create_table "ownerships", :force => true do |t|
      t.integer  "user_id"
      t.integer  "ownable_id"
      t.integer  "role_id"
      t.string   "ownable_type"
      t.timestamps
    end

    create_table "roles", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.timestamps
    end

    change_table :assignments do |t|
      t.rename :subject_id, :row_id
      t.rename :permission_mask, :permission
    end
  end

end
