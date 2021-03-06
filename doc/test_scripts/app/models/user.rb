require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of      :level,      :in => ['liveline','user']
  validates_length_of          :login,      :within => 6..100 
  validates_uniqueness_of   :login
  validates_format_of         :login,       :with => Authentication.email_regex,    :message => Authentication.bad_email_message
  validates_presence_of      :first_name, :last_name, :login
  validates_numericality_of  :mobile, :allow_nil => true
  validates_numericality_of  :phone, :allow_nil => true

  attr_protected :level
  attr_accessor :current_user_right,:can_add_users
  
  has_many :ownerships
  has_many :owners, :through => :ownerships,:conditions =>["ownable_type=?",'user'] 

  has_many :inverse_ownerships, :class_name => "Ownership", :foreign_key => "ownable_id"
  has_many :inverse_owners, :through => :inverse_ownerships ,:conditions =>["ownable_type=?",'user'] ,:source =>:user
	
	has_many :owned_mrcs,:class_name=>"Mrc",:through =>:ownerships ,:conditions =>["ownable_type=?",'mrc'] ,:source=>:mrc,:include =>[:ownerships]
	has_many :owned_clients ,:class_name=>"Client",:through =>:ownerships ,:conditions =>["ownable_type=?",'client'],:source=>:client,:include =>[:ownerships]
	has_many :owned_projects ,:class_name=>"Project",:through =>:ownerships ,:conditions =>["ownable_type=?",'project'],:source=>:project,:include =>[:ownerships]
	
	named_scope :all_users,:conditions=>['level =?','user']
  
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase)
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def name
    "#{first_name} #{last_name}"
  end
  
	def is_liveline?
	  self.level == 'liveline'
	end
	
	def is_user?
	  self.level == 'user'
	end
	
	def my_role
		self.ownerships.all(:conditions=>['ownable_type=?','self'],:select=>[:role_id]).first.role_id
	end	
	
	def liveline_owner 
		@owner = self.owners.all(:conditions=>['role_id=? and level=?','1','liveline'])
		if !@owner.blank?
			return true
		else
			return false
		end	
	end	
		
	def mrc_owner
	 @owner = self.mrcs.select{|mrc| mrc.current_user_right == 1}
		if !@owner.blank?
			return true
		else
			return false
		end
	end	
	
	def client_owner
	 @owner = self.clients.select{|mrc| mrc.current_user_right == 1}
		if !@owner.blank?
			return true
		else
			return false
		end
	end	
	
	def mrcs
			@the_mrcs  ||= []
			if self.is_user?
					@the_mrcs << self.owned_mrcs
				  if self.owners
						 self.owners.each do |owner|
					     @the_mrcs << owner.mrcs
						end
					end	
				else
					@the_mrcs << Mrc.all
					role = self.my_role
				end
			set_roles(@the_mrcs,role)
		@the_mrcs
	end
			
	def clients
		@the_clients ||= []
	     if self.is_user?
	       self.mrcs
						  if !@the_mrcs.blank?
							  	@the_mrcs.each do |mrc|
										@the_clients <<  set_roles(mrc.clients,mrc.current_user_right)
								  end
					   	end
				    @the_clients <<  self.owned_clients
		    else
			    role = self.my_role
    	   @the_clients = Client.all
		   end
		set_roles(@the_clients,role)
	 @the_clients
	end
	
	def  projects
		@the_projects ||= []
	   if self.is_user?
			 self.clients
			 if !@the_clients.blank?
					@the_clients.each do |client|
						if !client.projects.blank?
						  @the_projects << set_roles(client.projects,client.current_user_right) 
					  end
					end
				end
				@the_projects << self.owned_projects
	  else
			role = self.my_role
			@the_projects = Project.all
		end
		set_roles(@the_projects,role)
		@the_projects
	end

  def users
		@the_users ||= []
		if self.is_user?
	   self.mrcs
	   self.clients
	   self.projects
		 populate_users(@the_mrcs)
		 populate_users(@the_clients)	 
		 populate_users(@the_projects)	
		else
	     role = self.my_role
			 @the_users = User.all
			 set_roles(@the_users,role)
		end	
		flatten_and_uniq(@the_users)
		@the_users
	end	
		
  private
	
	def populate_users(items)
		if !items.blank?
		   items.each do |item|
          if !item.users.blank?
				 @the_users <<	set_roles(item.users,item.current_user_right)
				 end
				end
	  end
	end
	
	def flatten_and_uniq(item)
		if !item.blank?
			item.flatten!
			item.uniq!
		end
		return item
	end
	
 def set_roles(items,*role)
		 if !items.blank?
			 flatten_and_uniq(items)
			 role = role.first

		 if role
			  items.each do |item|
					if item.current_user_right
				    item.current_user_right	= role if item.current_user_right > role
				  else
						item.current_user_right	= role
					end
				end
			else
			  items.each do |item|
				  if 	item.current_user_right.blank?
					  role = self.ownerships.all(:conditions=>["ownable_type =? and ownable_id =?",item.class.to_s.downcase,item.id]).first.role_id						
						item.current_user_right = role
					end
				end
		end		
	 end	
 end	
 
	protected
   
end
