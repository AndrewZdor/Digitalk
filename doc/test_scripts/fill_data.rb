require '../../config/environment.rb'

#~ (16..20).to_a.each do |el|
	#~ Ownership.create(:user_id=>el,:ownable_id=>(el-16),:ownable_type=>'project',:role_id=>[1,2,3].rand)
   #~ u = User.new
   #~ u.login = "user#{el}@gmail.com"
   #~ u.password = 'testing'
   #~ u.password_confirmation = 'testing'
   #~ u.first_name = "user"
   #~ u.last_name = "#{el}"
   #~ u.level = 'user'
   #~ u.save
   #~ m = Mrc.new
   #~ m.name = "mrc #{el}"
   #~ m.save
	 #~ c= Client.new
   #~ c.name = "client #{el}"
   #~ c.mrc_id = el 
	 #~ c.save
	 
	 #~ p= Project.new
   #~ p.title= "project #{el}"
   #~ p.client_id = el 
	 #~ p.save
	 
#~ end

u3  = User.find(3)
u3.mrcs.each do |mrc|
	puts mrc.inspect
	puts mrc.current_user_right
end	
#~ puts "I am hereeeeeeeee"
u3.clients.each do |client|
	puts client.inspect
	puts client.current_user_right
end	
#~ puts u3.users.inspect
u3.projects.each do |pr|
	puts pr.inspect
	puts pr.current_user_right
end	

u3.users.each do |pr|
	puts pr.inspect
	puts pr.current_user_right
end	

#~ puts Project.first.methods.sort


#~ (102..121).to_a.each do |id|
#~ Ownership.find(id).destroy
#~ end








