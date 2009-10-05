class MrcsController < EntityController

  MODEL = Mrc # TODO: Grab it from rails metadata.

#  FIXME: Analyze this.
#  before_filter :get_mrcs,:only=>[:index,:edit_mrc_form,:live_search,:destory,:reset_filter]
#  before_filter :can_add_mrc ,:only=>[:index,:edit_mrc_form,:create,:destroy,:cancel,:load_mrc_form,:update]

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

end
