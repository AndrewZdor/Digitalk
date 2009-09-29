class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
		Role.create(:name=>'admin',:description=>'admin')
		Role.create(:name=>'write',:description=>'write')
		Role.create(:name=>'read',:description=>'read')
  end

  def self.down
    drop_table :roles
  end
end
