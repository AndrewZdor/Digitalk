class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, :with => :rescue_record_not_found
  rescue_from SecurityError, :with => :rescue_security_error # TODO: Replace with something more accurate.
  rescue_from ActiveRecord::RecordNotSaved, :with => :rescue_record_not_saved

  helper :all

  protect_from_forgery
  filter_parameter_logging :password

  include AuthenticatedSystem

  private

  def admin_required
      raise SecurityError unless current_user.admin?
  end

  #-------------------------------- Rescue from errors.

    def rescue_record_not_found
      flash.now[:error] = "Record not found - model:#{@e_name}, id:#{@Id}"
      logger.error flash[:error]
      redirect_back_or_default(:root)
    end

    def rescue_security_error
      flash.now[:error] = "#{current_user.login} not authorized to access this page!"
      flash[:error] = "#{current_user.login} is not authorized to access this page!"
      logger.error flash[:error]
      redirect_back_or_default(:root)
    end

    def rescue_record_not_saved
      flash.now[:error] = "Record cannot be saved - model:#{@e_name}, id:#{@Id}!"
          + @entity.errors.full_messages.join("<br />")
      logger.error flash[:error]
      redirect_back_or_default(:root)
    end

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
