# Superclass for all controllers that need authenticated user.
class EntityController < ApplicationController

  before_filter :login_required
  before_filter :admin_required
  before_filter :analyze_params # Analize params before each action.

  #-------------------------------- Actions.

  # Show main entity screen with navigation and form.
  def index
    @entities = current_user.all_allowed_in @model

    locals = {:model => @model, :entities => @entities}
    render :template => ENTITY_VIEW, :locals => locals
  end


  # 'q' parameter used as filter. Empty string resets filter.
  def filter
    @entities = current_user.all_allowed_in @model # OPTIMIZE!!!
    @entities = @entities.select{|m| m.name =~ /#{params[:q]}/}

    respond_to do |format|
      format.js do
        render :update do |page|
          node_id = @e_name + '-nav'
          page.replace_html node_id, :partial => @e_name + '_navigation',
              :locals => {:model => @model, :entities => @entities}
          page.visual_effect :highlight, node_id

        end
      end
    end
  end


  # Render editing part of the view for given entity, defined by 'cls' and 'id' params.
  def edit_form
    respond_to do |format|
      format.js do
        render :update do |page|
          view_name = @e_name.pluralize + '/' + @e_name + '_form'
          locals = {:model => @model, :entity => @entity}

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
    @entity.update_attributes(params[@e_name]) # Throws ActiveRecord::RecordNotSaved

    respond_to do |format|
      format.js do
        render :update do |page|
          #Refresh entity list if present.
          @entities = current_user.all_allowed_in @model
          nav_path = @e_plural + '/' + @e_name + '_navigation'
          locals = {:model => @model, :entities => @entities}
          page.replace_html 'entity-nav', :partial => nav_path, :locals => locals
          page.visual_effect :highlight ,'entity-nav'

          # Render notification
          flash.now[:notice] = "Successfully saved."
          page.replace_html 'flash', :partial => 'shared/flash'
          page.visual_effect :highlight ,'flash'
        end
      end # format.js do
    end # respond_to do |format|
  end # update


  # Cancels (re-reads) current record being edited.
  def cancel
    flash.now[:notice] = "Successfully cancelled."
    edit_form
  end


  # Makes copy of the current record.
  def copy
    @entity = @entity.clone
    @id = -1

    flash[:notice] = "Successfully copied."
    edit_form
  end


  # Permanently delete given object.
  def destroy
    raise SecurityError unless current_user.can_delete @entity

    @entity.destroy # FIXME: Error handling!

    flash.now[:notice] = "Successfully deleted."
    index
  end


  # Creates new unsaved record.
  def create
    raise SecurityError unless current_user.can_create @model

    @entity = @model.new(:root => Root.first) # FIXME: Temp workaround !!!
    @id = -1

    flash.now[:notice] = "New record."
    edit_form
  end


  #-------------------------------- Misc.
  private

  # Read and validate parameters.
  def analyze_params
    @cls = params[:cls]
    @model = eval(controller_name.capitalize + 'Controller::MODEL')
    @model = eval(@cls.capitalize) if !@model and @cls

    @e_name = @model.name.downcase
    @e_plural = @e_name.pluralize
    @e_description = eval(@model.name + '::DESCRIPTION')

    @id = params[:id] unless @id
    @entity = @model.find(@id) if @id and !@entity

    # Row validation.
    if !@entity
      raise ActiveRecord::RecordNotFound if @id
    elsif !@entity.allowed_for current_user
      raise SecurityError
    end
  end

end