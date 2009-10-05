class ClientsController < EntityController

  MODEL = Client # TODO: Grab it from rails metadata.



#
#  before_filter :get_mrcs_and_clients,:only=>[:index,:edit_client_form,:load_client_form,:live_search,:cancel,:reset_filter]
#  before_filter :get_clients,:only=>[:show_clients]
#  before_filter :get_mrcs,:only=>[:load_client_form,:create,:destroy]
#  before_filter :can_add_client ,:only=>[:index,:edit_mrc_form,:create,:destroy,:load_client_form,:cancel,:load_client_form]
#  before_filter :owned_mrcs,:only=>[:load_client_form]
#
#
#  def index
#    respond_to do |format|
#      @client = Client.new
#      owned_mrcs
#      @user_action = 'new'
#      format.html
#    end
#  end
#
#def create
#  @client = Client.new(params[:client])
#  respond_to do |format|
#   format.js do
#     if current_user.can_add_users
#       if @client.save
#         @client = Client.new
#         @user_action = 'new'
#          get_clients
#          owned_mrcs
#          render:update do |page|
#           page.replace_html 'client_list', :partial => 'client_list'
#           page.replace_html 'client_form', :partial => 'client_form'
#           page.visual_effect :highlight ,'client_form'
#           page.alert("Client is created successfully")
#          end
#       else
#         render:update do |page|
#          page.replace_html 'client_errors', @client.errors.full_messages.join("<br />")
#        end
#      end
#     end
#    end
#   end
#  end
#
#
#  def load_client_form
#   respond_to do |format|
#    format.js do
#     if current_user.can_add_users and !@owned_mrcs.blank?
#        @client= Client.new
#        @user_action = 'new'
#        render:update do |page|
#          page.replace_html 'client_form', :partial => 'client_form'
#          page.visual_effect :highlight ,'client_form'
#        end
#    else
#    render:update do |page|
#     page.alert("You are not authorise to add clients!")
#    end
#   end
#   end
#  end
# end
#
#  def edit_client_form
#   respond_to do |format|
#   format.js do
#     @client = Client.find(params[:id])
#     if @client and !@clients.blank?
#        @user_action = 'edit'
#        @the_client = @clients.select{|u| u.id == @client.id}
#        @the_client = @the_client.first if @the_client.class == Array
#        @client.current_user_right = @the_client.current_user_right
#         owned_mrcs
#         render:update do |page|
#           page.replace_html 'client_form', :partial => 'client_form'
#           page.visual_effect :highlight ,'client_form'
#        end
#    else
#     render:update do |page|
#      page.alert("The Client not found!")
#     end
#     end
#    end
#   end
#  end
#
#
#  def update
#    @client = Client.find(params[:id])
#    respond_to do |format|
#      format.js do
#        if @client and @client.update_attributes(params[:client])
#          owned_mrcs
#          @client = Client.new
#          @user_action = 'new'
#          get_clients
#          render:update do |page|
#           page.replace_html 'client_form', :partial => 'client_form'
#           page.visual_effect :highlight ,'client_form'
#           page.replace_html 'client_list', :partial => 'client_list'
#           page.visual_effect :highlight ,'client_lists'
#           page.alert("Client is updated successfully")
#           end
#        else
#          render:update do |page|
#            page.replace_html 'client_errors', @client.errors.full_messages.join("<br />")
#          end
#        end
#       end
#     end
#end
#
#
#  def destroy
#   respond_to do |format|
#    format.js do
#      @client = Client.find(params[:id])
#        if @client
#           ownership = @client.ownerships.all(:conditions=>["ownable_type =?",'client'])
#           if ownership
#             ownership.each {|o| o.destroy}
#           end
#           @client.destroy
#           @user_action = 'new'
#           @client = Client.new
#           owned_mrcs
#           get_clients
#           render:update do |page|
#             page.replace_html 'client_list', :partial => 'client_list'
#             page.replace_html 'client_form', :partial => 'client_form'
#             page.visual_effect :highlight ,'client_form'
#             page.alert("Client is destroyed successfully")
#          end
#        else
#           render:update do |page|
#           page.alert("The client not found!")
#          end
#      end
#     end
#    end
#  end
#
#
#  def show_clients
#    respond_to do |format|
#     format.js do
#      @mrc = Mrc.find(params[:id])
#      if @mrc
#         @mrc_clients = @mrc.clients
#        if !@mrc_clients.blank? and !@clients.blank?
#            @owned_clients = @clients.dup
#            @clients = []
#             @mrc_clients.each do |mrc_client|
#               client = @owned_clients.select{|u| u.id == mrc_client.id}
#               if !client.blank?
#                 client = client.first if client.class == Array
#                 mrc_client.current_user_right = client.current_user_right
#                 @clients << client
#               end
#             end
#        else
#          @clients = []
#        end
#        render:update do |page|
#             page.replace_html 'reset_link', :partial => 'reset_link'
#            page.replace_html 'client_list', :partial => 'client_list'
#            page.visual_effect :highlight ,'client_list'
#          end
#       end
#     end
#  end
#end
#
#  def live_search
#    respond_to do |format|
#      format.js do
#        if @mrcs
#           @mrcs= @mrcs.select{|m| m.name =~ /#{params[:q]}/}
#        end
#        render:update do |page|
#          page.replace_html 'reset_link', :partial => 'reset_link'
#        page.replace_html 'mrc_list', :partial => 'mrc_list'
#        page.visual_effect :highlight ,'mrc_list'
#      end
#    end
#  end
# end
#
#
#  def cancel
#    respond_to do |format|
#      format.js do
#       @client = Client.new
#       @user_action = 'new'
#       owned_mrcs
#        render:update do |page|
#           page.replace_html 'client_form', :partial => 'client_form'
#           page.visual_effect :highlight ,'client_form'
#        end
#      end
#  end
#end
#
#  def reset_filter
#    respond_to do |format|
#      format.js do
#        render:update do |page|
#           page.replace_html 'client_list', :partial => 'client_list'
#           page.replace_html 'mrc_list', :partial => 'mrc_list'
#           page.replace_html 'reset_link', ''
#           page.visual_effect :highlight ,'client_list'
#           page.visual_effect :highlight ,'mrc_list'
#        end
#      end
#    end
#    end
#
#private
#
#def owned_mrcs
#  @owned_mrcs = []
#   if @mrcs
#    @mrcs.each do |mrc|
#     @owned_mrcs << mrc if [1,2].include?(mrc.current_user_right)
#    end
#  end
#
#  end


end