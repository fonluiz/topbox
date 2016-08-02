class DocumentsController < ApplicationController

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.save
    redirect_to '/home'
    #redirect_to(action: "show", id: @documents)
  end

  def index
    @documents = Document.order :name
  end

  def show
    @document = Document.find(params[:id])
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    #usar redirect_to para redirecionar para parent_directory
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Restaurante.find params[:id]
    @document.update_attributes(document_params)

    redirect_to action: "show", id: @document
  end


  private
  def document_params
    params.require(:document).permit(:name, :content)
  end

end
