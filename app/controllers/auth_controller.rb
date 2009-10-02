# Superclass for all controllers that need authenticated user.
class AuthController < ApplicationController

  before_filter :login_required
  before_filter :admin_required

end