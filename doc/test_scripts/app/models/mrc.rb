class Mrc < ActiveRecord::Base
	has_many :clients, :dependent => :nullify
	has_many :ownerships,:foreign_key=>'ownable_id'
  has_many :users, :through => :ownerships,:conditions =>["ownable_type=?",'mrc'] ,:source=>:user
  attr_accessor :current_user_right
	
	validates_presence_of      :name
  validates_length_of          :name,      :within => 3..40
	
	def projects
		the_projects = []
		 if self.clients.blank?
			self.clients.each do |cl|
			 if !cl.projects.blank?
				 the_projects << cl.projects
			end
			end
		end
		if the_projects
	   the_projects.flatten! 	
	   the_projects.uniq!
	 end
	 the_projects
	end
	
	
end
