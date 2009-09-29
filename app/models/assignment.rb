# == Schema Information
# Schema version: 20090928102943
#
# Table name: assignments
#
#  id                    :integer(4)      not null, primary key
#  user_id               :integer(4)
#  entity_id             :integer(4)
#  permission_mask       :integer(4)      default(0)
#  assigned_by_user_id   :integer(4)
#  created_at            :datetime
#  updated_at            :datetime
#  security_subject_id   :integer(4)
#  security_subject_type :string(255)
#

class Assignment < ActiveRecord::Base

  belongs_to :user
  belongs_to :security_subject, :polymorphic => true

  validates_presence_of :user_id, :entity_id, :subject_id, :permission_mask
  validates_uniqueness_of :subject_id, :scope => [:user_id, :entity_id]

  #Disallow assignments for respondent users.
   validate :validate_isAdmin
   def validate_isAdmin
     return if user.isAdmin
     errors.add_to_base("Administrators only can be given assignments!")
   end

  attr_protected :assigned_by_user_id

end
