class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :client
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.boolean :display

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
