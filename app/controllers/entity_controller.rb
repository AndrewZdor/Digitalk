# Superclass for all controllers that need authenticated user.
class EntityController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, :with => :rescue_record_not_found
  rescue_from SecurityError, :with => :rescue_security_error # TODO: Replace with something more accurate.
  rescue_from ActiveRecord::RecordNotSaved, :with => :rescue_record_not_saved

  before_filter :login_required
  before_filter :admin_required

  before_filter :can_create, :only => [:copy, :create]

  before_filter :analyze_params # Analize params before each action.

  #-------------------------------- Actions.

  # Show main entity screen with navigation and form.
  def index
    @entities ||= nil
    render :template => ENTITY_VIEW, :locals => {:model => @model, :entities => @entities}
  end


  # 'q' parameter used as filter. Empty string resets filter.
  def filter
    class_name = @class.name.downcase
logger.debug "---------------------- target:#{@target}"
    if @target # Filter applied on another list, its model name given as 'target' param.
      model = Kernel.const_get(@target.capitalize)
      node_id = @target + '-nav'
      condition = "#{class_name}_id = #{@id}" #ZZZ: Improve security, use hash conditions.
    else # Filter applied on the calling list.
      model = @class
      node_id = class_name + '-nav'
      condition = params[:q] ? "name LIKE '%#{params[:q]}%'" : nil
    end
    entities = current_user.all_allowed_in model, condition # FIXME: Take care of Projects (title, no name).
logger.debug "---------------------- model:#{model.name}"
    respond_to do |format|
      format.js do
        render :update do |page|
          # Render search-list.
          page.replace_html node_id, :partial => SEARCH_LIST_VIEW,
              :locals => {:model => model, :entities => entities}
          page.visual_effect :highlight, node_id

          # Render notification - needed after update.
          if flash.any?
            page.replace_html 'flash', :partial => 'shared/flash'
            page.visual_effect :highlight ,'flash'
          end
        end
      end
    end
  end


  # Render editing part of the view for given entity, defined by 'cls' and 'id' params.
  def edit_form
    m_name = @model.name.downcase
    view_name = m_name.pluralize + '/' + m_name + '_form'
    locals = {:model => @model, :entity => @entity}

    respond_to do |format|
      format.js do
        render :update do |page|
          # Render form and actions.
          page.replace_html 'entity-form', :partial => view_name, :locals => locals
          page.visual_effect :highlight ,'entity-form'

          # Render notifications.
          if flash.any?
            page.replace_html 'flash', :partial => 'shared/flash'
            page.visual_effect :highlight ,'flash'
          end
        end
      end # format.js do
    end # respond_to do |format|
  end # edit_form


  # Save or commit form.
  def update
    raise SecurityError unless current_user.can_modify @entity
    @entity.update_attributes(params[@model.name.downcase]) # Throws ActiveRecord::RecordNotSaved

    # Refresh navigation list for updated model.
    @class = @model
    @target = nil
    flash.now[:notice] = "Successfully saved."
    filter
  end # update


  # Cancels (re-reads) current record being edited.
  def cancel
    flash.now[:notice] = "Successfully cancelled."
    edit_form
  end


  # Makes copy of the current record.
  def copy
    @entity = @entity.clone

    flash.now[:notice] = "Successfully copied."
    edit_form
  end


  # Creates new unsaved record.
  def create
    @entity = @model.new(:root => Root.first) # FIXME: Temp workaround !!!

    flash.now[:notice] = "New record."
    edit_form
  end


  # Permanently delete given object.
  def destroy
    raise SecurityError unless current_user.can_delete @entity

    @entity.destroy # FIXME: Error handling!
    flash[:notice] = "Successfully deleted."
    index
  end

  #-------------------------------- Misc.
  private

  def can_create
    raise SecurityError unless current_user.can_create @model
  end

  # Read and validate parameters.
  def analyze_params
    @class = Kernel.const_get(params[:cls].capitalize) if params[:cls]
    @model = eval(controller_name.capitalize + 'Controller::MODEL') #TODO: Change eval to something more legitimate.

    @id = params[:id]
    @entity = (params[:cls] ? @class : @model).find(@id) if @id

    # Row validation.
    if !@entity
      raise ActiveRecord::RecordNotFound if @id
    elsif !@entity.allowed_for current_user
      raise SecurityError
    end

    @target = params[:tgt]
  end


  #-------------------------------- Rescue from errors.
  # --- Andrew DON'T MOVE IT FROM HERE cause instance vars are used in messages!!!

    def rescue_record_not_found
      flash[:error] = "Record not found - model:#{@e_name}, id:#{@Id}"
      logger.error flash[:error]
      redirect_back_or_default(:root)
    end

    def rescue_security_error
      flash[:error] = "#{current_user.login} not authorized to access this page!"
      logger.error flash[:error]
      redirect_back_or_default(:root)
    end

    def rescue_record_not_saved
      flash[:error] = "Record cannot be saved - model:#{@e_name}, id:#{@Id}!"
          + @entity.errors.full_messages.join("<br />")
      logger.error flash[:error]
      redirect_back_or_default(:root)
    end

end