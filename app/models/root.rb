# == Schema Information
# Schema version: 20091007074557
#
# Table name: roots
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#

class Root < ActiveRecord::Base

  DESCRIPTION = 'MRC Contractors'

  include SecuritySubject

  has_many :assignments, :as => :security_subject, :dependent => :destroy

  def to_s
    self[:name]
  end
end
