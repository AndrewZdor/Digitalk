class ProjectsController < ApplicationController
  before_filter :login_required
  before_filter :get_projects,:only=>[:index,:show_projects,:edit_project_form,:reset_filter]
	before_filter :get_mrcs ,:only=>[:index,:live_search,:reset_filter]
  before_filter :get_clients ,:only=>[:index,:load_project_form,:edit_project_form,:create,:update,:destroy,:cancel,:reset_filter]
  before_filter :can_add_project ,:only=>[:index,:load_project_form,:create,:update,:destroy,:cancel]
  before_filter :owned_clients,:only=>[:index,:load_project_form,:edit_project_form,:update,:create,:destroy,:cancel]
  
	def index
    respond_to do |format|
      @project = Project.new
      @user_action = "new"
			format.html 
    end
  end


  def create
    @project = Project.new(params[:project])
      respond_to do |format|
       format.js do
         if current_user.can_add_users
           if @project.save
              @project = Project.new
              @user_action = 'new'
              get_projects
							owned_clients
              render:update do |page|
                page.replace_html 'project_list', :partial => 'project_list'
                page.replace_html 'project_form', :partial => 'project_form'
                page.visual_effect :highlight ,'project_form'
                page.alert("Project is created successfully")
              end   
           else
               render:update do |page|
                page.replace_html 'project_errors', @project.errors.full_messages.join("<br />")
              end   
           end  
         end  
         end  
      end
  end

  def update
   @project = Project.find(params[:id])
		respond_to do |format|
      format.js do 
        if @project and @project.update_attributes(params[:project])
           @project = Project.new
           @user_action = 'new'
					 get_projects
          render:update do |page|
           page.replace_html 'project_list', :partial => 'project_list'
           page.replace_html 'project_form', :partial => 'project_form'
           page.visual_effect :highlight ,'project_form'
           page.alert("Project is updated successfully")
           end   
        else
          render:update do |page|
            page.replace_html 'project_errors', @project.errors.full_messages.join("<br />")
          end   
        end
       end
     end
  end

  def destroy
    respond_to do |format|
    format.js do
      @project = Project.find(params[:id])
	      if @project 
           ownership = @project.ownerships.all(:conditions=>["ownable_type =?",'project'])
           if ownership 
					   ownership.each {|o| o.destroy} 
					 end
					 @project.destroy
           @user_action = 'new'
           @project = Project.new
           get_projects
           render:update do |page|
             page.replace_html 'project_list', :partial => 'project_list'           
             page.replace_html 'project_form', :partial => 'project_form'
             page.visual_effect :highlight ,'project_form'
             page.alert("Project is destroyed successfully")
          end 
        else
           render:update do |page|
           page.alert("The Project not found!")
          end  	 
    	end
     end	  
    end
  end
  

  def load_project_form
   respond_to do |format|
    format.js do
     if current_user.can_add_users  and !@clients.blank?
	      @project= Project.new
	      @user_action = 'new'
				render:update do |page|
				  page.replace_html 'project_form', :partial => 'project_form'
          page.visual_effect :highlight ,'project_form'
        end
    else
	  render:update do |page|
	   page.alert("You are not authorise to add Projects!")
    end	 
	 end	  
   end	    
  end	  
end

	
 def edit_project_form
   respond_to do |format|
   format.js do
     @project = Project.find(params[:id])
     if @project
        @user_action = 'edit'
				@the_project = @projects.select{|p| p.id == @project.id}
        @the_project = @the_project.first if @the_project.class == Array
				@project.current_user_right = @the_project.current_user_right
				 render:update do |page|
					 page.replace_html 'project_form', :partial => 'project_form'
					 page.visual_effect :highlight ,'project_form'
				end
	  else
	   render:update do |page|
      page.alert("The Project not found!")
	   end  	 
	   end  	 
    end
   end
  end


  def show_projects
   respond_to do |format|
	  format.js do
			@client = Client.find(params[:id])
			if @client
			  @client_projects = @client.projects
				  if !@client_projects.blank? and !@projects.blank? 
				   @owned_projects = @projects.dup
					 @projects = []
					 @client_projects.each do |client_project|
					   project = @owned_projects.select{|p| p.id == client_project.id}
	 					  if !project.blank? 
 							 project = project.first if project.class == Array
							 client_project.current_user_right = project.current_user_right
							 @projects << client_project
						 end
					 end
					 render:update do |page|
             page.replace_html 'reset_link', :partial => 'reset_link'
				  	page.replace_html 'project_list', :partial => 'project_list'
					  page.visual_effect :highlight ,'project_list'
				  end
					else
						render:update do |page|
				  	page.replace_html 'project_list', 'no projects found'
				  end
				end
			end					
	   end	  
	end	  
end

 def show_clients
    respond_to do |format|
	   format.js do
			@mrc = Mrc.find(params[:id])
			 @clients = @mrc.clients if @mrc
				render:update do |page|
          page.replace_html 'reset_link', :partial => 'reset_link'
				  	page.replace_html 'client_list', :partial => 'client_list'
					  page.visual_effect :highlight ,'client_list'
				  end	  
  	   end	  
	   end
end

  def live_search
    respond_to do |format|
      format.js do
				if @mrcs
				   @mrcs= @mrcs.select{|m| m.name =~ /#{params[:q]}/}
        end
				render:update do |page|
        page.replace_html 'reset_link', :partial => 'reset_link'
        page.replace_html 'mrc_list', :partial => 'mrc_list'
        page.visual_effect :highlight ,'mrc_list'
      end 
    end 
  end 
end

def cancel
    respond_to do |format|
      format.js do
       @project = Project.new
       @user_action = 'new'
        render:update do |page|
					 page.replace_html 'project_form', :partial => 'project_form'
					 page.visual_effect :highlight ,'project_form'
				end
      end  
  end  
end  
  
    def reset_filter
    respond_to do |format|
      format.js do
        render:update do |page|
					 page.replace_html 'client_list', :partial => 'client_list'
					 page.replace_html 'mrc_list', :partial => 'mrc_list'
					 page.replace_html 'project_list', :partial => 'project_list'
           page.replace_html 'reset_link', ''
					 page.visual_effect :highlight ,'client_list'
					 page.visual_effect :highlight ,'mrc_list'
					 page.visual_effect :highlight ,'project_list'
				end
      end  
    end  
    end  
	

private

def owned_clients
  @owned_clients = []
   if @clients
    @clients.each do |client|
     @owned_clients << client if [1,2].include?(client.current_user_right)
    end
  end

  end

end
#end of class