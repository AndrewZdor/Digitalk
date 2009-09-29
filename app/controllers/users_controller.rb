class UsersController < ApplicationController
 before_filter :login_required
 before_filter :can_add_users ,:only=>[:index,:load_user_form,:create,:find_owned_users,:destroy,:update,:cancel]
 before_filter :find_owned_items,:only=>[:index,:load_user_form,:edit_user_form,:update,:destroy,:reset_filter,:cancel,:create]
 before_filter :get_users,:only=>[:set_children,:get_project_users]
 
 
 def index
   @user_action = 'new'
   @user = User.new
	 respond_to do |format|
   format.html
	 end
 end
 
 def create
   @user = User.new(params[:user])
   @user.level  = 'user'
    respond_to do |format|
      format.js do
        if current_user.can_add_users
	        if @user.save
            set_relations
            @user = User.new
	          @user_action = 'new'	
            get_users
            render:update do |page|
             page.replace_html 'user_form', :partial => 'user_form'
             page.replace_html 'user_list', :partial => 'user_list'
             page.visual_effect :highlight,'user_list'
             page.visual_effect :highlight,'user_form'
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
     @user = User.find(params[:id],:include=>[:ownerships])
	   render:update do |page|
	    if @user
				@user_action = 'edit'
        @ownerships = @user.ownerships
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
   @user = User.find(params[:id])
	 @user.level  = 'user' if @user
    respond_to do |format|
      format.js do
	     if @user.update_attributes(params[:user])
	        @user.ownerships.each {|o| o.destroy}	  
					set_relations
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
      @user = User.find(params[:id])
        if @user
           @user.ownerships.each {|o| o.destroy}
           @user.destroy
           @user_action = 'new' 
					 get_users
          render:update do |page|
							page.replace_html 'user_list', :partial => 'user_list'
							page.visual_effect :highlight ,'user_list'
							page.replace_html 'user_form', :partial => 'user_form'
							page.visual_effect :highlight ,'user_form'
							page.alert("User is destroyed successfully")
          end
        end 
     end	  
    end	  
  end
  
  def set_children
    respond_to do |format|
      format.js do
       if params[:class_name] == 'mrc'
			  @item = Mrc.find(params[:id]) 
			 else
				 @item = Client.find(params[:id]) 
			 end
	       if @item
          
					@the_users = []
					@mrcs =[] 
					@clients =[] 
					@projects =[]
					
					if @item.class == Mrc
           @mrcs << @item
           @clients = @item.clients
					 @projects = @item.projects
					else
					 @mrcs <<@item.mrc
					 @clients << @item
					 @projects =@item.projects
				 end 
				 
				    populate_users(@clients)
				 		populate_users(@mrcs)
						populate_users(@projects)
						set_roles
           render:update do |page|
             if @item.class == Mrc
              page.replace_html 'client_list', :partial => 'client_list'
              page.visual_effect :highlight ,'client_list'
             else
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
		@projects =[]
	  if @project
	   @the_users =[] 
		 @projects << @project
	   populate_users(@projects)
     set_roles
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
		flatten_and_uniq(items)
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
	
	  
  def flatten_and_uniq(item)
   if item 
    item.flatten!
    item.uniq!
   end
  end 
  
  def set_relations
    create_relations(params[:filter_admin_mrcs],'mrc','admin')
	           create_relations(params[:filter_admin_clients],'client','admin')
	           create_relations(params[:filter_admin_projects],'project','admin')
					   create_relations(params[:filter_write_mrcs],'mrc','write')
	           create_relations(params[:filter_write_clients],'client','write')
	           create_relations(params[:filter_write_projects],'project','write')
					   create_relations(params[:filter_read_mrcs],'mrc','read')
	           create_relations(params[:filter_read_clients],'client','read')
	           create_relations(params[:filter_read_projects],'project','read')
  end  
def  set_roles
	owned_users = []
	 if !@the_users.blank?
			@the_users.each do |user|
				 if !@users.blank?
				   found_user = @users.select{|u| u.id == user.id}
				 end
				 if !found_user.blank?
					 found_user= found_user.first if found_user.class == Array
					 user.current_user_right = found_user.current_user_right
				 end
				owned_users << user
			end
		end
		@users = owned_users 
 end
 
 def create_relations(params,item,role)
	 case role
		when 'admin'
		 role_id =  1
		when 'write'
		 role_id =  2
		else
	 	 role_id =  3
 	 end	
			
	 if !params.blank?
		 params.each do |num|
       Ownership.create(:user_id=>@user.id,:ownable_id=>num,:ownable_type=>item,:role_id=>role_id)
		 end
   end
 end
 
end
#end for class