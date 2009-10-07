# == Schema Information
# Schema version: 20091007074557
#
# Table name: projects
#
#  id          :integer(4)      not null, primary key
#  client_id   :integer(4)
#  name        :string(255)
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
  has_many :surveys
  has_many :blogs

  has_many :assignments, :as => :security_subject, :dependent => :destroy

  validates_presence_of   :name
  validates_length_of     :name, :within => 3..40

  validates_uniqueness_of :name, :scope => :client
end
