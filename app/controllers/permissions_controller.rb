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
    return false
  end

  def belongs_to_current_user?
    user = @permission.privacy.shareable.user
    user_id = user.id
    return user_id == get_current_user.id
  end

  def authorPermission?
    @permission.privacy.permissions.each do |permission|
      if (permission.user_id == get_current_user.id) 
        return permission.editar?
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
    if already_shared?
      redirect_to edit_permission_path(get_permission), notice: 'Esse compartilhamento já existe. Deseja atualizar?'
    else 
      respond_to do |format|
      if @permission.save

        create_notification
        format.html { redirect_to @permission.privacy.shareable }

        format.json { render :show, status: :created, location: @permission }
      else
        format.html { render :new }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
        end
      end
    end
  end



  # PATCH/PUT /permissions/1
  # PATCH/PUT /permissions/1.json
  def update
    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to @permission.privacy.shareable }
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

    def already_shared?
      return !(Permission.where(privacy_id: @permission.privacy.id, user_id: @permission.user_id).blank?)    
    end

    def get_permission
      return Permission.find_by(privacy_id: @permission.privacy.id, user_id: @permission.user_id)
    end

  def create_notification
    user_id = params[:permission][:user_id]

    privacy_id = params[:permission][:privacy_id]
    privacy = Privacy.find(privacy_id)

    shareable = privacy.get_shareable

    Notification.create(user_id: user_id,
                        notified_by_id: get_current_user.id,
                        document_id: document.id)
  end

end