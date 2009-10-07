# == Schema Information
# Schema version: 20091007074557
#
# Table name: mrcs
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  address    :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  root_id    :integer(4)
#

class Mrc < ActiveRecord::Base

  DESCRIPTION = 'Market Research Companies'

  include SecuritySubject

  belongs_to :root
  has_many :clients, :dependent => :nullify

  has_many :assignments, :as => :security_subject, :dependent => :destroy

#	has_many :ownerships,:foreign_key=>'ownable_id'
#  has_many :users, :through => :ownerships,:conditions =>["ownable_type=?",'mrc'] ,:source=>:user

#  attr_accessor :current_user_right

  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_length_of     :name, :within => 3..40

#  def projects
#    the_projects = []
#     if !self.clients.blank?
#      self.clients.each do |cl|
#       if !cl.projects.blank?
#         the_projects << cl.projects
#      end
#      end
#    end
#    if the_projects
#     the_projects.flatten!
#     the_projects.uniq!
#   end
#   the_projects
#  end

end
