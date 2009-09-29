class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.references :project
      t.string :title
      t.text :description
      t.datetime :published_date
      t.boolean :is_approved

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
