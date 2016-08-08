class DocumentsController < ApplicationController
  include DocumentsHelper, ApplicationHelper
  helper_method :create_default_doc

  def new
    @document = Document.new
  end

  def create
    @document = Document.new
    @document.folder = get_current_folder
    @document.name = NEW_DOCUMENT_NAME

    if @document.save
      redirect_to MAIN_FOLDER_PATH + get_current_folder.id.to_s
    else
      redirect_to '/blablabla'
    end
  end

  def index
    @documents = Document.all
  end

  def show
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

  def create_default_doc
    @doc = Document.new
    @doc.folder = get_current_folder
    @doc.name = NEW_DOCUMENT_NAME

    if @doc.save
      redirect_to MAIN_FOLDER_PATH + get_current_folder.id.to_s
    end
  end

  private
  def get_document_params
    params.require(:document).permit(:name, :content)
  end

end