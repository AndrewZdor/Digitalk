class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.references :project
      t.string :title
      t.text :description
      t.datetime :published_date
      t.boolean :is_published

      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
