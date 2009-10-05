class ApplicationController < ActionController::Base

  helper :all

  protect_from_forgery
  filter_parameter_logging :password

  include AuthenticatedSystem

  private

#	def can_add_mrc
#    if current_user.is_user?
#       current_user.can_add_users = true if current_user.liveline_owner
#	  else
#      current_user.can_add_users = true if current_user.my_role == 1
#   end
# end
#
#	def can_add_client
#	    if current_user.is_user?
#       current_user.can_add_users = true if (current_user.liveline_owner || current_user.mrc_owner )
#    else
#      current_user.can_add_users = true if current_user.my_role == 1
#    end
#	end
#
#	def can_add_project
#	    if current_user.is_user?
#       current_user.can_add_users = true if (current_user.liveline_owner || current_user.mrc_owner || current_user.client_owner )
#    else
#      current_user.can_add_users = true if current_user.my_role == 1
#    end
#	end

end
