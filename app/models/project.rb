class Project < ActiveRecord::Base
	  has_many :ownerships,:foreign_key=>'ownable_id'
    has_many :users, :through => :ownerships,:conditions =>["ownable_type=?",'project'] ,:source=>:user
		belongs_to :client
		attr_accessor :current_user_right
		validates_presence_of :title
		validates_length_of :title,:within=>3..40
end
