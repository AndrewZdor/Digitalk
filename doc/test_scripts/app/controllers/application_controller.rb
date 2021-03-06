class ApplicationController < ActionController::Base
  helper :all 
  protect_from_forgery 
	include AuthenticatedSystem
  
	private
	
	def can_add_mrc
    if current_user.is_user? 
       current_user.can_add_users = true if current_user.liveline_owner
	  else
      current_user.can_add_users = true if current_user.my_role == 1
   end
 end
	
	def can_add_client 
	    if current_user.is_user? and (current_user.liveline_owner || current_user.mrc_owner )
       current_user.can_add_users = true 
    else
      current_user.can_add_users = true if current_user.my_role == 1
    end
	end
	
	def can_add_project
	    if current_user.is_user? and (current_user.liveline_owner || current_user.mrc_owner || current_user.client_owner )
       current_user.can_add_users = true 
    else
      current_user.can_add_users = true if current_user.my_role == 1
    end
	end
	
	def can_add_users
	    can_add_project
	end
	
	def find_owned_items
		get_mrcs
		get_clients
		get_projects
		get_users
  end
	
	def get_mrcs
			 @mrcs = current_user.mrcs
	end
	
	def get_mrcs_and_clients
		get_mrcs
		get_clients
	end
	
	def get_pmc
		get_mrcs_and_clients
		get_projects
	end
	
	
	def get_clients
			 @clients = current_user.clients
	end
	
	def get_projects
		@projects= current_user.projects
	end
	
	
	def get_users
		@users= current_user.users
	end
	
end
