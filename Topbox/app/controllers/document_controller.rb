class DocumentController < ApplicationController

  def new
    @document = Document.new
  end

  def create
    @document = Document.new params.require(:document).permit(:name)
    @document.save
    #redirect_to(action: "show", id: @document)
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


end
