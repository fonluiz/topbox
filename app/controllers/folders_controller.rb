class FoldersController < ApplicationController
  include FoldersHelper, ApplicationHelper
  before_action :require_user, only: [:index, :show, :edit, :update, :destroy, :move_to_trash]
  before_action :set_folder, only: [:show, :edit, :update, :destroy, :move_to_trash, :upload_file]
  helper_method :get_folder_path, :move_to_trash

  # GET /folders
  # GET /folders.json
  def index
    @folder = find_mytopbox
    redirect_to_mytopbox   #redirect_to_mytopbox
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @my_folders = get_my_folders
    @my_documents = get_my_documents
    @folder_content = get_my_folders + get_my_documents
    @initial_index = 1
    @page = [params[:pg].to_i,1].max
    @initial_index = (@page-1)*PAGE_MAX unless @page <= 1
    @folder_page_content = @folder_content[@initial_index-1..((@initial_index+6))]
    if has_folder? && !@folder.trash
      set_current_folder(@folder)
    else
      render 'permissions/denied'
    end
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  def shared
    permissions = Permission.where(user_id: get_current_user.id)
    @shared_files = permissions.select do |permission|
      (permission.privacy.shareable.trash ==  false)
    end
  end

  def upload
    @document = Document.new
    render 'upload'
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(get_folder_params, )
    @folder.parent = get_current_folder
    @folder.user = get_current_user
    if @folder.save
      set_current_folder(@folder)
      redirect_to_current_folder
    end
  end

  # GET /folders/1/edit
  def edit
    set_current_folder(@folder)
    if @folder.trash
      render "permissions/denied"
      
    end
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

    def show_trash
    @trash_documents = get_trash_documents
    @trash_folders = get_trash_folders
    render 'folders/trash'
  end
  def move_to_trash
    set_folder
    unless @folder == find_mytopbox 
      @folder.make_trash
      redirect_to_mytopbox
    end
  end

  def recycle
    set_folder
    unless @folder == find_mytopbox
      @folder.make_recycle
      redirect_to_mytopbox      
    end
  end

  def recycle_all
    get_trash_folders.each{|folder| folder.make_recycle}
    get_trash_documents.each{|document| document.make_recycle}
    redirect_to trash_path
  end


  def trash_destroy_all
    get_trash_folders.each{|folder| folder.destroy}
    get_trash_documents.each{|document| document.destroy}
    redirect_to trash_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_folder
    @folder = Folder.find(params[:id])
  end

  def get_folder_params
    params.require(:folder).permit(:name)
  end

  def has_folder?
    return @folder.user.id == get_current_user.id
  end

  def get_my_folders
    Folder.where(parent_id: @folder.id, user_id: get_current_user.id, trash: false)
  end

  def get_my_documents
    Document.where(folder_id: @folder.id, trash: false)
  end

  def get_trash_folders
    all_user_trash_folders = Folder.where(user: get_current_user, trash:true)
    no_parents= all_user_trash_folders.select{|folder| !folder.parent.trash}
  end

  def get_trash_documents
    all_trash_documents = Document.where(trash: true)
    all_user_trash_document = all_trash_documents.select {|document| document.folder.user == get_current_user && !(document.folder.trash)}
  end

end