class MrcsController < EntityController

  MODEL = Mrc # TODO: Grab it from rails metadata.

  def index
    @entities = current_user.all_allowed_in Mrc
    super
  end

end
