# == Schema Information
# Schema version: 20090928102943
#
# Table name: user_groupings
#
#  id               :integer(4)      not null, primary key
#  group_user_id    :integer(4)
#  user_id          :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#  project_id       :integer(4)
#  project_group_id :integer(4)
#

class UserGrouping < ActiveRecord::Base

  # Mandatory
  belongs_to :group, :class_name => 'User', :foreign_key=>'group_user_id'
  belongs_to :user

  # Optionally - for respondents.
  belongs_to :project
  belongs_to :project_group

  validates_presence_of :group_user_id, :user_id
  validates_uniqueness_of :user_id, :scope => :group_user_id

  # Respondent must be assigned onto the project and have defined group type.
  validates_presence_of :project_id, :project_group_id,
      :unless => 'user.isAdmin' #FIXME: Is it correct?
  validates_uniqueness_of :user_id,
      :scope => :project_id, :unless => 'project_id.blank?'
  validates_presence_of :project_group_id, :if => 'project_id.blank?'

  #Disallow nested groups.
  validate :validateGroupNested
  def validateGroupNested
    return if user.isGroup == group.isGroup
    errors.add_to_base("Groups cannot be nested!")
  end

  #Disallow mixed groups.
  validate :validateGroupMixed
  def validateGroupMixed
    return if user.isAdmin == group.isAdmin
    errors.add_to_base("Administrator and respondent users canot be mixed within the group!")
  end

end
