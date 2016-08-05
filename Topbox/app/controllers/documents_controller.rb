class DocumentsController < ApplicationController

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.holder = current_folder

    if @document.save
      redirect_to '/mytopbox/'+current_folder.id.to_s
    else
      redirect_to '/documents'
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
    redirect_to '/home/my_documents'
    #usar redirect_to para redirecionar para parent_directory
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find params[:id]
    @document.update_attributes(document_params)

    redirect_to action: "show", id: @document
  end

  private
  def document_params
    params.require(:document).permit(:name, :content)
  end

end