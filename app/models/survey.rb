# == Schema Information
# Schema version: 20091007074557
#
# Table name: surveys
#
#  id             :integer(4)      not null, primary key
#  project_id     :integer(4)
#  title          :string(255)
#  description    :text
#  published_date :datetime
#  is_approved    :boolean(1)
#  created_at     :datetime
#  updated_at     :datetime
#

class Survey < ActiveRecord::Base

  belongs_to :project

end
