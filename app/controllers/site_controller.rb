class SiteController < ApplicationController

  skip_before_filter :admin_required, :except => [:dashboard]

  def home
  end

  def about
  end

  def services
  end

  def our_work
  end

  def contact
  end

  def dashboard
  end


end
