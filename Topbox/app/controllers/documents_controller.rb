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
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to MAIN_FOLDER_PATH + get_current_folder.id.to_s
  end

  def edit
    @document = Document.find(params[:id])
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

end