class PopulateAssignments < ActiveRecord::Migration

  def self.up
    r = Root.create(:name => 'LiveLine')
    r.save
    Mrc.update_all("root_id = #{r.id}")

    [Root, Mrc, Client, Project].each do |model|
      u = User.new
      u.login = u.first_name = u.last_name = model.name + 'Admin@gmail.com'
      u.password = u.password_confirmation = 'letmecomein'
      u.is_admin = true
      u.save

      Assignment.create(:user => u,
          :security_subject => model.first, # first object.
          :permission_mask => 02 # full rights.
          ).save
    end

  end

  def self.down
    Mrc.update_all("root_id = NULL")
#    Root.first.destroy

    %w(Root Mrc Client Project).each  do |tmp|
      User.destroy_all(:login => tmp + 'Admin@gmail.com')
    end
  end

end
