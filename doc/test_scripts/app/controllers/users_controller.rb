class UsersController < ApplicationController
 before_filter :login_required
 before_filter :can_add_users ,:only=>[:index,:load_user_form,:create,:find_owned_users,:destroy,:update,:cancel]
 before_filter :find_owned_items,:only=>[:index,:get_project_users,:load_user_form,:edit_user_form,:update,:destroy,:reset_filter,:cancel]
 
 
 def index
   @user_action = 'new'
   @user = User.new
	 respond_to do |format|
   format.html
	 end
 end
 
 def create
   @user = User.new(params[:user])
   @user.parent_id = 1
   @user.level = 'user'
   @owners = []
   @owners << params[:filter_mrc] if params[:filter_mrc] 
   @owners << params[:filter_client] if params[:filter_client] 
   flatten_and_uniq(@owners)
    respond_to do |format|
      format.js do
        if current_user.can_add_users
	        if @user.save
	          if @owners
             @owners.each do |owner|    
	            Ownership.create(:ownable_id=>@user.id, :user_id=>owner,:ownable_type=>"user",:role=>params[:role])
            end	    
	         end	  
            @user = User.new
	          @user_action = 'new'	
            render:update do |page|
             page.replace_html 'user_form', :partial => 'user_form'
             page.alert("User is added Successfully")
	          end
          else
            render:update do |page| 
             page.replace_html :error_messages	,@user.errors.full_messages.join("<br />")   
             page.visual_effect :pulsate,:error_messages	
            end	  
         end	
      else
       render:update do |page| 
        page.alert("You are not authorise to add users!")	
       end 
      end 
     end 
    end
  end
 
  def edit_user_form
   respond_to do |format|
    format.js do
     @user = User.first(:conditions=>['id=?',params[:id]],:include=>[:inverse_ownerships,:projects])
     logger.info @user.inverse_ownerships
		 @user_action = 'edit'
	   render:update do |page|
	    if @user
	      @the_user = @users.select{|u| u.id == @user.id}
	      if @the_user
					@the_user = @the_user.first if @the_user.class == Array
				  @user.current_user_right = @the_user.current_user_right
				end
				page.replace_html 'user_form', :partial => 'user_form'
        page.visual_effect :highlight ,'user_form' 	
	    else
	     page.alert("The user not found!")
	   end  	 
	  end  	 
    end
   end
  end
   
   def update
   @user = User.find(params[:id],:include=>[:inverse_ownerships])
   @user.parent_id = 1
   @user.level = 'user'
   @owners = []
   @owners << params[:filter_mrc] if params[:filter_mrc] 
   @owners << params[:filter_client] if params[:filter_client] 
   flatten_and_uniq(@owners)
    respond_to do |format|
      format.js do
	     if @user.update_attributes(params[:user])
	        @user.inverse_ownerships.each {|o| o.destroy}	  
	        if @owners
		        @owners.each do |owner|    
	           Ownership.create(:ownable_id=>@user.id, :user_id=>owner,:ownable_type=>"user",:role=>params[:role])
		        end	    
	        end
          @user = User.new
          @user_action = 'new'
    	   render:update do |page|
	       page.replace_html 'user_form', :partial => 'user_form'
	       page.visual_effect :highlight,'user_form'
	       page.alert("User is updated successfully")
	      end
	    else
	      render:update do |page| 
	      page.replace_html :error_messages ,@user.errors.full_messages.join("<br />")
	     end	  
 	  end
   end  
   end
  end
    
    
  def load_user_form
   respond_to do |format|
    format.js do
     if current_user.can_add_users  
	     render:update do |page|
	      @user = User.new
	      @user_action = 'new'
	      page.replace_html 'user_form', :partial => 'user_form'
        page.visual_effect :highlight ,'user_form'
      end
    else
	  render:update do |page|
	   page.alert("You are not authorise to add users!")
    end	 
	 end	  
   end	    
  end	  
  end	
  
  def destroy
    respond_to do |format|
     format.js do
      @user = User.find(params[:id],:include=>[:inverse_ownerships])
	     render:update do |page|
        if @user
           @user.inverse_ownerships.each {|o| o.destroy}
           @user.destroy
           @user_action = 'new' 
          page.replace_html 'user_list', :partial => 'user_list'
          page.visual_effect :highlight ,'user_list'
          page.replace_html 'user_form', :partial => 'user_form'
          page.visual_effect :highlight ,'user_form'
          page.alert("User is destroyed successfully")
        else
           page.alert("The user not found!")
        end  	 
    	end
     end	  
    end	  
  end
  
  def set_children
    respond_to do |format|
      format.js do
       @item = params[:class_name].capitalize.classify.find(params[:id]) 
	       if @item
          if @item.class == Mrc
					 @users ||= []
           @clients = @item.clients
           @projects = @item.projects
           
					 elsif @user.level == 'client' and @clients
           @user = @clients.select{|m| m.id == @user.id}
         end 
           @user = @user.first if @user.class == Array
           @users = @clients = @projects = @mrcs = nil
          find_children_and_users(@user,@user.current_user_right)
           render:update do |page|
             if @user.level == 'mrc'
              page.replace_html 'client_list', :partial => 'client_list'
              page.visual_effect :highlight ,'client_list'
             elsif @user.level == 'client'
              page.replace_html 'mrc_list', :partial => 'mrc_list'
              page.visual_effect :highlight ,'mrc_list'
            end
              page.replace_html 'reset_filter', :partial => 'reset_link'
              page.replace_html 'user_list', :partial => 'user_list'
              page.visual_effect :highlight ,'user_list'
              page.replace_html 'project_list', :partial => 'project_list'
              page.visual_effect :highlight ,'project_list'
          end
        end
       end
    end
  end  
   
 def get_project_users
  respond_to do |format|
   format.js do
    @project = Project.find(params[:id])	
	  @project = @projects.find{|p| p.id == @project.id}
	  if @project
	   @users =  @project.users.all(:conditions=>['level =?','user']) 
     write_roles(@project.current_user_right)
	  end
	 render :update do |page|
     page.replace_html 'user_list', :partial => 'user_list'
     page.replace_html 'reset_filter', :partial => 'reset_link'
	   page.visual_effect :highlight ,'user_list'
     end
   end
   end
 end

 def reset_filter
  respond_to do |format|
   format.js do
    render :update do |page| 
    page.replace_html 'reset_filter', ''
    page.replace_html 'client_list', :partial => 'client_list'
    page.replace_html 'mrc_list', :partial => 'mrc_list'
    page.replace_html 'user_list', :partial => 'user_list'
    page.replace_html 'project_list', :partial => 'project_list'
    page.visual_effect :highlight ,'mrc_list'
    page.visual_effect :highlight ,'user_list'
    page.visual_effect :highlight ,'client_list'
    page.visual_effect :highlight ,'project_list'
    end    
   end    
  end    
 end    
 
   def cancel
    respond_to do |format|
      format.js do
       @user = User.new
       @user_action = 'new'
        render:update do |page|
					 page.replace_html 'user_form', :partial => 'user_form'
					 page.visual_effect :highlight ,'user_form'
				end
      end  
  end  
end  

private
	def populate_users(items)
		if !items.blank?
		   items.each do |item|
          if !item.users.blank?
				   @the_users <<	item.users
				 end
				end
			end
			if @the_users
	    	@the_users.flatten!
			  @the_users.uniq!
			end
	end
	
end
#end for class