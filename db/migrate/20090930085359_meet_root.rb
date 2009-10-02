class MeetRoot < ActiveRecord::Migration

  def self.up
    drop_table :entities

    create_table :roots do |t|
      t.string :name
      t.string :description
    end

    change_table :mrcs do |t|
      t.references :root
    end

    Root.new(:name => 'LiveLine').save

    remove_column :assignments, :entity_id
  end

  def self.down
    create_table "entities", :force => true do |t|
      t.string   "name"
      t.integer  "parent_id"
      t.timestamps
    end

    remove_column :mrcs, :root_id

    add_column :assignments, :entity_id, :integer
  end

end
