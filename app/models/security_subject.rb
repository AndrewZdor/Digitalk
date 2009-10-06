# Mixed-in to model objects. Adds security harness.
module SecuritySubject

  # Declarative models hierarvhy.
  # TODO: Implement calculating hierarchy using rails metadata - see commented master_model below.
  H_LEVELS = {Root => 0, Mrc => 1, Client => 2, Project => 3}
  H_PARENTS = {Root => nil, Mrc => Root, Client => Mrc, Project => Client}

  #  # Lazily initializes master (parent) model in model hierarchy.
  #  # Uses the first (!!!) 'belongs_to' assosiasion to other Securable model.
  #  def master_model
  #    assocs = self.class.reflect_on_all_associations(:belongs_to)
  #    return nil if assocs == nil || assocs.empty?
  #    assoc = assocs.find {|a| a.klass.included_modules.include?(Securable)}
  #    return nil if assoc == nil
  #    @@master_attr = assoc.name[1..-1] + '_id' # assotiated attribute.
  #    @@master_model = assoc.klass
  #  end

  # Callback for extending Mixee classes.
  def self.included model
    model.extend ClassMethods
  end

  # Workaround for extending model classes with 'class' methods.
  module ClassMethods
  end

  # Get the instance of master model or nil if the self is an instance of root.
  def master_entity
    master_model = H_PARENTS[self.class]
    return nil unless master_model
    master_id = self[master_model.name.downcase + '_id']
    return nil unless master_id
    master_model.find(master_id)
  end

  # Climbs up the hierarchy tree until given condition is false or root object reached.
  # Returns array of model objects, including starting one.
  def climb_up #&condition
    entities = []
    entity = self
    begin
      entities << entity
#      break if block_given? and condition.call
    end while entity = entity.master_entity
    entities
  end

  # Returns true if self object allowed for viewing by given user.
  # Internally checks if this or top-level parents have assignments for given user.
  def allowed_for (user)
    groups_n_users = user.groups_n_users
    climb_up.any? {|e| e.assignments.any? {|a| groups_n_users.include? a.user} }
  end

  # Returns permissions for given securable object.
  def get_permission
  end

end