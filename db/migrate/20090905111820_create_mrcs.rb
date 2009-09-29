class CreateMrcs < ActiveRecord::Migration
  def self.up
    create_table :mrcs do |t|
      t.string :name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :mrcs
  end
end
