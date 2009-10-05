# Superclass for all controllers that need authenticated user.
class EntityController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, :with => :rescue_record_not_found
  rescue_from SecurityError, :with => :rescue_security_error # TODO: Replace with something more accurate.
  rescue_from ActiveRecord::RecordNotSaved, :with => :rescue_record_not_saved

  before_filter :login_required
  before_filter :admin_required

  #-------------------------------- Actions.

  # Show main entity screen with navigation and form.
  def index
    get_params
    @entities = @model.all_allowed_for current_user

    locals = {:model => @model, :entities => @entities}
    render :template => 'shared/_entity', :locals => locals
  end


  # 'q' parameter used as filter. Empty string resets filter.
  def filter
    get_params
    @entities = @model.all_allowed_for current_user # OPTIMIZE!!!
    @entities = @entities.select{|m| m.name =~ /#{params[:q]}/}

    respond_to do |format|
      format.js do
        render :update do |page|
          view_name = @e_name + '_navigation'
          locals = {:model => @model, :entities => @entities}
          page.replace_html view_name, :partial => view_name, :locals => locals
          page.visual_effect :highlight, view_name

          page.replace_html 'flash', :partial => 'shared/flash'
          page.visual_effect :highlight ,'flash' if flash.any?
        end
      end
    end
  end


  # Render editing part of the view for given entity, defined by 'cls' and 'id' params.
  def edit_form
    get_params
    respond_to do |format|
      format.js do
        render :update do |page|
          view_name = @e_name.pluralize + '/' + @e_name + '_form'
          page.replace_html 'entity-form',
              :partial => view_name, :locals => {:entity => @entity}
          page.visual_effect :highlight ,'entity-form'

          page.replace_html 'flash', :partial => 'shared/flash'
          page.visual_effect :highlight ,'flash' if flash.any?
        end
      end # format.js do
    end # respond_to do |format|
  end # edit_form


  # Save or commit form.
  def update
    get_params
    @entity.update_attributes(params[@e_name]) # Throws ActiveRecord::RecordNotSaved
    respond_to do |format|
      format.js do
        render :update do |page|
          #Refresh entity list if present.
          @entities = @model.all_allowed_for current_user
          nav_path = @e_plural + '/' + @e_name + '_navigation'
          locals = {:model => @model, :entities => @entities}
          page.replace_html 'entity-navigation', :partial => nav_path, :locals => locals
          page.visual_effect :highlight ,'entity-navigation'

          flash.now[:notice] = "Successfully saved."
          page.replace_html 'flash', :partial => 'shared/flash'
          page.visual_effect :highlight ,'flash' if flash.any?
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
    get_params
    @entity = @entity.clone
    @id = -1
    flash.now[:notice] = "Successfully copied."
    edit_form
  end


  #-------------------------------- Misc.

  private

    # Read and validate parameters.
    def get_params
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

    def admin_required
      raise SecurityError unless current_user.admin?
    end

 #-------------------------------- Rescue from errors.

  private

    def rescue_record_not_found
      flash.now[:error] = "Record not found - model:#{@e_name}, id:#{@Id}"
      logger.error flash[:error]
      redirect_to :back
    end

    def rescue_security_error
      flash.now[:error] = "#{current_user.login} not authorized to access this page!"
      flash[:error] = "#{current_user.login} is not authorized to access this page!"
      logger.error flash[:error]
      redirect_to :root
    end

    def rescue_record_not_saved
      flash.now[:error] = "Record cannot be saved - model:#{@e_name}, id:#{@Id}!"
          + @entity.errors.full_messages.join("<br />")
      logger.error flash[:error]
      redirect_to :root
    end

end