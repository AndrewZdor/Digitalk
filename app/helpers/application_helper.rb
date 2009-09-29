# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

def authorise_to_add_or_edit
    if (current_user.can_add_users and @user_action == 'new')||(@user_action == 'edit')
      return true
    else 	
     return false
    end
 end
 
   def authorized_user(role,item)
    case role
		
		when 'admin'
		  if item.current_user_right.to_i == 1
         return true	    
      else
       return false	    
		 end
		
		when 'write'
		  if [1,2].include?(item.current_user_right)
				return true	    
      else
       return false	    
		 end
		 else
		 if [1,2,3].include?(item.current_user_right)
				return true	    
      else
       return false	    
		 end
	 end
	 
  end
   
	
	def check_role(item,role)
    if item.self_role == role
     return true
    else
     return false
    end 
  end	
	
  def check_relation(role,item,the_user,item_type)
    case role
     when 'admin' 
      role_id = 1
     when 'write' 
      role_id = 2
     when 'read' 
      role_id = 3
     else
       
    end   
    ownership = @ownerships.select{|o| (o.ownable_id== item.id and o.ownable_type == item_type)}
    ownership =ownership.first if !ownership.blank?
    if !ownership.blank? and ownership.role_id == role_id
      return true
    else
     return false
    end 
  end

end
