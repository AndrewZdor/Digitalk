class CreateOwnerships < ActiveRecord::Migration
  def self.up
    create_table :ownerships do |t|
      t.integer :user_id
      t.integer :ownable_id
      t.integer :role_id
			t.string :ownable_type
      t.timestamps
    end
    
		 u = User.new
		 u.login='cromano@aberonit.com'
		 u.first_name='Carmen'
		 u.last_name='Romano'
		 u.password='4aberon4'
		 u.password_confirmation= '4aberon4'
		 u.level='liveline'
		 
	 if u.save
     o = Ownership.create(:user_id=>u.id,:ownable_id=>u.id, :ownable_type=>'self',:role_id=>1)
   end
   
  end

  def self.down
    drop_table :ownerships
  end
end
