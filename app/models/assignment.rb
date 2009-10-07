# == Schema Information
# Schema version: 20091007074557
#
# Table name: assignments
#
#  id                    :integer(4)      not null, primary key
#  user_id               :integer(4)
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

  validates_presence_of :user_id, :security_subject_type, :security_subject_id, :permission_mask
  validates_uniqueness_of :security_subject_id, :scope => [:user_id, :security_subject_type]

  #Disallow assignments for respondent users.
   validate :validate_is_admin
   def validate_is_admin
     return if user.is_admin
     errors.add_to_base("Administrators only can be given assignments!")
   end

#  attr_protected :assigned_by_user_id

end
