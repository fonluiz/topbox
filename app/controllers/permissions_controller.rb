class PermissionsController < ApplicationController
  before_action :set_permission, only: [:show, :edit, :update, :destroy]

  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = Permission.all
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
  end

  # GET /permissions/new
  def new
    @permission = Permission.new
    @permission.privacy_id = params[:p]
    if params[:p].blank?
      redirect_to_current_folder
    end
    unless isAuthorized?
      redirect_to_current_folder
    end
  end


  def isAuthorized?
    return true if belongs_to_current_user?
    @permission.privacy.permissions.each do |permission|
      if (permission.user_id == get_current_user.id) 
        return permission.author?
      end
    end
    return false
  end

  def belongs_to_current_user?
    return @permission.privacy.shareable.folder.user.id == get_current_user.id
  end

  def authorPermission?
    @permission.privacy.permissions.each do |permission|
      if (permission.user_id == get_current_user.id) 
        return permission.author?
      end
    end
  end


  def denied
  end

  
  # GET /permissions/1/edit
  def edit
  end

  # POST /permissions
  # POST /permissions.json
  def create
    @permission = Permission.new(permission_params)
    respond_to do |format|
      if @permission.save
        format.html { redirect_to @permission.privacy.shareable, notice: 'Permission was successfully created.' }
        format.json { render :show, status: :created, location: @permission }
      else
        format.html { render :new }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permissions/1
  # PATCH/PUT /permissions/1.json
  def update
    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to @permission, notice: 'Permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @permission }
      else
        format.html { render :edit }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.json
  def destroy
    @permission.destroy
    respond_to do |format|
      format.html { redirect_to permissions_url, notice: 'Permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    def set_permission
      @permission = Permission.find(params[:id])
    end

    def permission_params
      params.require(:permission).permit(:privacy_id,:user_id, :status)
    end
end