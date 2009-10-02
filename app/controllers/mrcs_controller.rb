class MrcsController < AuthController

#  FIXME: Analyze this.
#  before_filter :get_mrcs,:only=>[:index,:edit_mrc_form,:live_search,:destory,:reset_filter]
#  before_filter :can_add_mrc ,:only=>[:index,:edit_mrc_form,:create,:destroy,:cancel,:load_mrc_form,:update]

  def index
#    @mrc = Mrc.new
#    @user_action = 'new'
    @mrcs = Mrc.all #FIXME: !!!
    respond_to do |format|
      format.html
    end
  end


#  def edit_mrc_form
#  respond_to do |format|
#   format.js do
#     @mrc = Mrc.find(params[:id])
#     if @mrc
#        @user_action = 'edit'
#        if @mrcs
#          @the_mrc = @mrcs.select{|u| u.id == @mrc.id}
#          @the_mrc = @the_mrc.first if(@the_mrc and @the_mrc.class == Array)
#          @mrc.current_user_right = @the_mrc.current_user_right
#        end
#         render:update do |page|
#           page.replace_html 'mrc_form', :partial => 'mrc_form'
#           page.visual_effect :highlight ,'mrc_form'
#        end
#    else
#     render:update do |page|
#      page.alert("The MRC not found!")
#     end
#     end
#    end
#   end
#  end
#
#
# def load_mrc_form
#  respond_to do |format|
#   format.js do
#     @mrc = Mrc.new
#     @user_action = 'new'
#      if current_user.can_add_users
#       render:update do |page|
#            page.replace_html 'mrc_form', :partial => 'mrc_form'
#            page.visual_effect :highlight ,'mrc_form'
#          end
#      else
#         render:update do |page|
#          page.alert("You can't add Mrcs!")
#         end
#       end
#     end
#    end
#   end
#
#
#   def create
#    @mrc = Mrc.new(params[:mrc])
#      respond_to do |format|
#       format.js do
#         if current_user.can_add_users
#           if @mrc.save
#              @mrc = Mrc.new
#              @user_action = 'new'
#              get_mrcs
#              render:update do |page|
#                page.replace_html 'mrc_list', :partial => 'mrc_list'
#                page.replace_html 'mrc_form', :partial => 'mrc_form'
#                page.visual_effect :highlight ,'mrc_form'
#                page.alert("Mrc is created successfully")
#              end
#           else
#               render:update do |page|
#                page.replace_html 'mrc_errors', @mrc.errors.full_messages.join("<br />")
#              end
#           end
#         end
#         end
#      end
#  end
#
#  def update
#   @mrc = Mrc.find(params[:id])
#    respond_to do |format|
#      format.js do
#        if @mrc and @mrc.update_attributes(params[:mrc])
#          @mrc = Mrc.new
#          @user_action = 'new'
#          render:update do |page|
#           page.replace_html 'mrc_form', :partial => 'mrc_form'
#           page.visual_effect :highlight ,'mrc_form'
#           page.alert("Mrc is updated successfully")
#           end
#        else
#          render:update do |page|
#            page.replace_html 'mrc_errors', @mrc.errors.full_messages.join("<br />")
#          end
#        end
#       end
#     end
#   end
#
#  def destroy
#    respond_to do |format|
#    format.js do
#      @mrc = Mrc.find(params[:id])
#        if @mrc
#           ownership = @mrc.ownerships.all(:conditions=>["ownable_type =?",'mrc'])
#           if ownership
#             ownership.each {|o| o.destroy}
#           end
#           @mrc.destroy
#           @mrc = Mrc.new
#           @user_action = 'new'
#           get_mrcs
#           render:update do |page|
#             page.replace_html 'mrc_list', :partial => 'mrc_list'
#             page.replace_html 'mrc_form', :partial => 'mrc_form'
#             page.visual_effect :highlight ,'mrc_form'
#             page.alert("Mrc is destroyed successfully")
#          end
#        else
#           render:update do |page|
#           page.alert("The mrc not found!")
#          end
#      end
#     end
#    end
#  end
#
#  def live_search
#    respond_to do |format|
#      format.js do
#        @mrcs= @mrcs.select{|m| m.name =~ /#{params[:q]}/}
#        render:update do |page|
#        page.replace_html 'reset_link', :partial => 'reset_link'
#        page.replace_html 'mrc_list', :partial => 'mrc_list'
#        page.visual_effect :highlight ,'mrc_list'
#      end
#    end
#  end
#end
#
#  def reset_filter
#    respond_to do |format|
#      format.js do
#        render:update do |page|
#           page.replace_html 'mrc_list', :partial => 'mrc_list'
#           page.replace_html 'reset_link', ''
#           page.visual_effect :highlight ,'mrc_list'
#        end
#      end
#    end
#    end
#
#  def cancel
#    respond_to do |format|
#      format.js do
#       @mrc = Mrc.new
#       @user_action = 'new'
#        render:update do |page|
#           page.replace_html 'mrc_form', :partial => 'mrc_form'
#           page.visual_effect :highlight ,'mrc_form'
#        end
#      end
#  end
#  end

end #end of class
