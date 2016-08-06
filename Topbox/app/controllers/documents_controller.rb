class DocumentsController < ApplicationController

  helper_method :default_create_doc

  def new
    @document = Document.new
  end

  def create
    @document = Document.new
    @document.folder = current_folder
    @document.name = "Documento sem título"

    if @document.save
      redirect_to '/mytopbox/'+current_folder.id.to_s
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
    redirect_to '/mytopbox/'+current_folder.id.to_s
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find params[:id]
    @document.update_attributes(document_params)

    redirect_to action: "show", id: @document
  end

  def default_create_doc
    @doc = Document.new
    @doc.folder = current_folder
    @doc.name = "Documento sem título"

    if @doc.save
      redirect_to '/mytopbox/'+current_folder.id.to_s
    end
  end

  private
  def document_params
    params.require(:document).permit(:name, :content)
  end

end