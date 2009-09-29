class Client < ActiveRecord::Base
  belongs_to:mrc
  has_many :ownerships,:foreign_key=>'ownable_id'
  has_many :users, :through => :ownerships,:conditions =>["ownable_type=?",'client'] ,:source=>:user
  has_many :projects ,:dependent => :nullify
	attr_accessor :current_user_right
		validates_presence_of      :name
  validates_length_of          :name,      :within => 3..40 

end
