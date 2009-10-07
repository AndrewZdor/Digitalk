class ClientsController < EntityController

  MODEL = Client # TODO: Grab it from rails metadata.

  def index
    @mrcs = current_user.all_allowed_in Mrc # At the beginning... there was bare screen and mrcs appeared ...
    super
  end

end