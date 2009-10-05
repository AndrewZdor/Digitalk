class CreateEntities < ActiveRecord::Migration
  def self.up
    create_table :entities do |t|
      t.string  :name
      t.integer :parent_id

      t.timestamps
    end

#    e = Entity.create(:name => "Root").save
#    e = Entity.create(:name => "MRC", :parent_id => e.id).save
#    e = Entity.create(:name => "Client", :parent_id => e.id).save
#    e = Entity.create(:name => "Project", :parent_id => e.id).save

  end

  def self.down
    drop_table :entities
  end
end
