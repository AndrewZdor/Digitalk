class DefaultPermission < ActiveRecord::Migration

  # Read-only permissions by default.
  def self.up
    change_column_default(:assignments, :permission_mask, 0)
  end

  def self.down
  end

end
