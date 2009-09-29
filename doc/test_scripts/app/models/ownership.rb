class Ownership < ActiveRecord::Base
    belongs_to :user
    belongs_to :project, :class_name => "Project",:foreign_key=>'ownable_id'
    belongs_to :mrc, :class_name => "Mrc",:foreign_key=>'ownable_id'
    belongs_to :client, :class_name => "Client",:foreign_key=>'ownable_id'
    belongs_to :owner, :class_name => "User",:foreign_key=>'ownable_id'
end
