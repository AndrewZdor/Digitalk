# == Schema Information
# Schema version: 20090930085359
#
# Table name: projects
#
#  id          :integer(4)      not null, primary key
#  client_id   :integer(4)
#  title       :string(255)
#  description :text
#  start_date  :date
#  end_date    :date
#  display     :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

class Project < ActiveRecord::Base

  DESCRIPTION = 'Projects'

  include SecuritySubject

  has_many :mrcs, :dependent => :nullify
  has_many :assignments, :as => :security_subject, :dependent => :destroy
  has_many :surveys
  has_many :blogs

#   has_many :ownerships,:foreign_key=>'ownable_id'
#   has_many :users, :through => :ownerships,:conditions =>["ownable_type=?",'project'] ,:source=>:user

# attr_accessor :current_user_right

  validates_presence_of   :title
  validates_uniqueness_of :name, :scope => :client
  validates_length_of     :title,:within => 3..40

  def name
    self.title
  end

end
