# == Schema Information
# Schema version: 20090928102943
#
# Table name: entities
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  parent_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

# Keeps hierarchical relations between models, defining security permissions hierarchy.
class Entity < ActiveRecord::Base

#  acts_as_tree :order => "name"

  # Self-reference.
  belongs_to :parent , :class_name => 'Entity'
  has_many :children, :class_name => 'Entity', :foreign_key => "parent_id"

  validates_presence_of :name
  validates_uniqueness_of :name

end
