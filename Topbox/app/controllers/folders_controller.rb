class FoldersController < ApplicationController
  include FoldersHelper, ApplicationHelper
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_mytopbox, only: [:index]
  helper_method :get_folder_path


  # GET /folders
  # GET /folders.json
  def index
    redirect_to_mytopbox
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    set_current_folder(@folder)
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new
    @folder.name = NEW_FOLDER_NAME
    @folder.parent = get_current_folder
    @folder.user = get_current_user

    if @folder.save
      redirect_to_current_folder
    end
  end

  # GET /folders/1/edit
  def edit
    set_current_folder(@folder)
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    parent_id = params.require(:folder).require(:parent)
    @parent = Folder.find(parent_id)
    respond_to do |format|
      @folder.parent = @parent
      if @folder.update(get_folder_params)
        format.html { redirect_to @folder, notice: folder_updated_msg(@folder.name) }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    parent = @folder.parent
    folder_name = @folder.name
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to parent, action: :show, notice: folder_destroyed_msg(folder_name) }
      format.json { head :no_content }
    end
  end

  # Returns the path of a folder
  public
  def get_folder_path(folder)
    full_path = folder.name
    divider = '<b style="color: #2251A6">  >  </b>'
    parent_folder = folder.parent
    until (parent_folder.nil?)
      full_path = (parent_folder.name + divider + full_path)
      parent_folder = parent_folder.parent
    end
    return full_path.html_safe
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_folder
    @folder = Folder.find(params[:id])
  end

  def get_folder_params
    params.require(:folder).permit(:name)
  end

end