class FixRoots < ActiveRecord::Migration
  def self.up
    Root.last.destroy()
    Mrc.update_all("root_id = #{Root.first.id}")
  end

  def self.down
    raise IrreversibleMigration
  end
end
