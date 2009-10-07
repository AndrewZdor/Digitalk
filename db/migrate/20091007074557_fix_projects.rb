class FixProjects < ActiveRecord::Migration
  def self.up
    rename_column :projects, :title, :name
  end

  def self.down
    raise IrreversibleMigration
  end
end
