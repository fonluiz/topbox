class DocumentsController < ApplicationController
  include DocumentsHelper, ApplicationHelper


  def new
    @document = Document.new
  end

  def create
    @document = Document.new
    @document.folder = get_current_folder
    @document.name = NEW_DOCUMENT_NAME

    if @document.save
      redirect_to_current_folder
    end
  end

  def index
    @documents = Document.all
  end

  def show
    require_user
    @document = Document.find(params[:id])
    unless has_read_permission?
      redirect_to MAIN_FOLDER_PATH
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to MAIN_FOLDER_PATH + get_current_folder.id.to_s
  end

  def edit
    @document = Document.find(params[:id])
    unless has_edit_permission?
      redirect_to MAIN_FOLDER_PATH
    end
  end

  def update
    @document = Document.find params[:id]
    folder_id = params.require(:document).require(:folder)
    @folder = Folder.find(folder_id)
    @document.folder = @folder
    @document.update_attributes(get_document_params)
    redirect_to action: ACTION_SHOW, id: @document
  end

  private
  def get_document_params
    params.require(:document).permit(:name, :content)
  end

    def has_edit_permission?
    return true if is_in_user_folders?(@document.folder)
    @document.permissions.each do |permission|
      return true if ((permission.user_id == get_current_user.id) and permission.write)
    end
    return false
  end

  def has_read_permission?
    return true if has_edit_permission?
    @document.permissions.each do |permission|
      return true if (permission.user_id == get_current_user.id)
    end
    return false
  end

  def is_in_user_folders?(folder)
    return false if folder.nil?
    if folder.user == get_current_user
      return true
    else
      return is_in_user_folders?(folder.parent)
    end
  end

end