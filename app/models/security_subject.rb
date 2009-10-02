# Tied to model objects
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

  # Returns array of items allowed for user to show for the current (self) model.
  def self.find_allowed

  end

  # Returns permissions for given securable object.
  def get_permission
  end


  # Get the instance of master model or nil if the self is an instance of root.
  def master_object
    master_model = H_PARENTS[self.class]
    return nil if master_model == nil
    master_model.find(master_model[master_model.downcase + '_id'])
  end

  # Returns root instance of the self object.
  # TODO: Select root with the most significant assignments.
  def root_instance
    tmp_instance = self
    while ((tmp_instance = master_instance()) != nil) do end
    tmp_instance
  end

  # Climbs up the hierarchy tree until root object reached.
  # If steps == 0 returns the self object, if 1 - the closest parent returned.
  def climb_up (steps = 0)
    tmp = self # The first objects under the feet.
    while tmp.nil? do
      yield tmp
    end
  end

end