# == Schema Information
# Schema version: 20090930085359
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  login                     :string(40)      default(""), not null
#  first_name                :string(100)     default("")
#  last_name                 :string(100)     default("")
#  crypted_password          :string(40)      default(""), not null
#  salt                      :string(40)
#  phone                     :string(255)
#  mobile                    :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  is_group                  :boolean(1)
#  is_admin                  :boolean(1)
#

require 'digest/sha1'

class User < ActiveRecord::Base

  DESCRIPTION = 'Users'

  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include SecuritySubject

  # --------------------------------- Data integrity.

  has_many :assignments, :dependent => :destroy
  has_many :user_groupings, :dependent => :destroy

  # From previous developer
  #  has_many :owned_mrcs,:class_name=>"Mrc",:through =>:ownerships ,:conditions =>["ownable_type=?",'mrc'] ,:source=>:mrc,:include =>[:ownerships]
  #  has_many :owned_clients ,:class_name=>"Client",:through =>:ownerships ,:conditions =>["ownable_type=?",'client'],:source=>:client,:include =>[:ownerships]
  #  has_many :owned_projects ,:class_name=>"Project",:through =>:ownerships ,:conditions =>["ownable_type=?",'project'],:source=>:project,:include =>[:ownerships]

  validates_length_of        :login, :within => 6..100
  validates_uniqueness_of    :login
  validates_format_of        :login, :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_presence_of      :first_name, :last_name, :login
  validates_numericality_of  :mobile, :allow_nil => true
  validates_numericality_of  :phone, :allow_nil => true

  validates_presence_of :is_admin, :if => 'is_group', :message => "Account must be of admin type to be a group."
  validate :is_group_valid?

  # Make this class' validation code DRY.
  validates_associated :assignments, :user_groupings , :on => :update

#  attr_accessor :current_user_right,:can_add_users

  attr_protected :is_admin

#  named_scope :all_users,:conditions=>['level =?','user']

  def is_group_valid?
    return unless is_group && !is_admin
    errors.add(:is_group, "Grouping is not allowed for non-administrators.")
  end


  # --------------------------------- Autentication.

  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase)
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def name
    "#{first_name} #{last_name}"
  end

  # --------------------------------- Permission management.

  def admin?
    self.is_admin
  end

  # Returns top-level assignment.
  def top_assignment
    return nil if assignments.empty?
    assignments.sort_by {|a| SecuritySubject::H_LEVELS[a.security_subject.class]}.first # OPTIMIZE: Use min_by
  end

  # Returns top-level assignment's entity name.
  def top_assignment_name
    a = top_assignment()
    return 'respondent' if a.nil?
    a.security_subject.name
  end

  # Returns all security accounts given user belongs to.
  def groups_n_users
    users = [self]
    unless self.user_groupings.empty?
      self.user_groupings.each {|ug| users << ug.group}
      users.uniq!
    end
    users
  end

  def can_create(model_class)

  end

  def can_modify(entity)
  end

  def can_delete(entity)
  end

  # --------------------------------- Misc.

  #  def my_role
#    self.ownerships.all(:conditions=>['ownable_type=?','self'],:select=>[:role_id]).first.role_id
#  end
#
#  def liveline_owner
#    @owner = self.owners.all(:conditions=>['role_id=? and level=?','1','liveline'])
#    if !@owner.blank?
#      return true
#    else
#      return false
#    end
#  end
#
#  def mrc_owner
#   @owner = self.mrcs.select{|mrc| mrc.current_user_right == 1}
#    if !@owner.blank?
#      return true
#    else
#      return false
#    end
#  end
#
#  def client_owner
#   @owner = self.clients.select{|mrc| mrc.current_user_right == 1}
#    if !@owner.blank?
#      return true
#    else
#      return false
#    end
#  end

#    def mrcs
#      @the_mrcs  ||= []
#      if self.is_user?
#          @the_mrcs << self.owned_mrcs
#          if self.owners
#             self.owners.each do |owner|
#               @the_mrcs << owner.mrcs
#            end
#          end
#        else
#          @the_mrcs << Mrc.all
#          role = self.my_role
#        end
#      set_roles(@the_mrcs,role)
#    @the_mrcs
#  end
#
#  def clients
#    @the_clients ||= []
#       if self.is_user?
#         self.mrcs
#              if !@the_mrcs.blank?
#                  @the_mrcs.each do |mrc|
#                    if !mrc.clients.blank?
#                      @the_clients <<  set_roles(mrc.clients,mrc.current_user_right)
#                    end
#                  end
#               end
#            @the_clients <<  self.owned_clients
#        else
#          role = self.my_role
#         @the_clients = Client.all
#       end
#    set_roles(@the_clients,role)
#   @the_clients
#  end
#
#  def  projects
#    @the_projects ||= []
#     if self.is_user?
#       self.clients
#       if !@the_clients.blank?
#          @the_clients.each do |client|
#            if !client.projects.blank?
#              @the_projects << set_roles(client.projects,client.current_user_right)
#            end
#          end
#        end
#        @the_projects << self.owned_projects
#    else
#      role = self.my_role
#      @the_projects = Project.all
#    end
#    set_roles(@the_projects,role)
#    @the_projects
#  end
#
#  def users
#    @the_users ||= []
#    if self.is_user?
#     self.mrcs
#     self.clients
#     self.projects
#     populate_users(@the_mrcs)
#     populate_users(@the_clients)
#     populate_users(@the_projects)
#    else
#       role = self.my_role
#       @the_users = User.all(:conditions=>["level =?","user"])
#       set_roles(@the_users,role)
#    end
#    flatten_and_uniq(@the_users)
#    @the_users
#  end
#
#  private
#
#  def populate_users(items)
#    if !items.blank?
#       items.each do |item|
#          if !item.users.blank?
#         @the_users <<	set_roles(item.users,item.current_user_right)
#         end
#        end
#    end
#  end
#
#  def flatten_and_uniq(item)
#    if !item.blank?
#      item.flatten!
#      item.uniq!
#    end
#    return item
#  end
#
# def set_roles(items,*role)
#     if !items.blank?
#       flatten_and_uniq(items)
#       role = role.first
#     if role
#        items.each do |item|
#          if item.current_user_right
#            item.current_user_right	= role if item.current_user_right > role
#          else
#            item.current_user_right	= role
#          end
#        end
#      else
#        items.each do |item|
#          if item.current_user_right.blank?
#            role = self.ownerships.all(:conditions=>["ownable_type =? and ownable_id =?",item.class.to_s.downcase,item.id]).first.role_id
#            item.current_user_right = role
#          end
#        end
#    end
#   end
# end
#
#  protected

end
