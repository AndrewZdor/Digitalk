class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                              :string, :limit => 40, :null => false
      t.column :first_name,                      :string, :limit => 100, :default => '', :null => true
      t.column :last_name,                       :string, :limit => 100, :default => '', :null => true
      t.column :crypted_password,            :string, :limit => 40, :null => false
      t.column :salt,                                :string, :limit => 40
      t.column :level,                               :string
      t.column :phone,                             :string
      t.column :mobile,                             :string
      t.column :created_at,                      :datetime
      t.column :updated_at,                     :datetime
      t.column :remember_token,             :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
    end
    add_index :users, :login, :unique => true

  end

  def self.down
    drop_table "users"
  end
end
