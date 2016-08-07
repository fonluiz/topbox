class DocumentsController < ApplicationController

  #Creates a document instance.
  def new
    @document = Document.new
  end

  ##
  def create
    @document = Document.new(document_params)
    @document.folder = current_folder


    puts
    puts current_folder.name

    puts
    if @document.save
      redirect_to '/folders/'+current_folder.id.to_s
    else
      redirect_to '/documents'
    end

    #redirect_to(action: "show", id: @documents)
  end

  #
  def index
    @documents = Document.all
  end

  #Show a document.
  def show
    @document = Document.find(params[:id])
  end

  #Erases a document and redirect the user to the parent directory.
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to '/home/my_documents'
    #usar redirect_to para redirecionar para parent_directory
  end

  #
  def edit
    @document = Document.find(params[:id])
  end

  #Update the document and show it.
  def update
    @document = Document.find params[:id]
    @document.update_attributes(document_params)

    redirect_to action: "show", id: @document
  end

  #
  private
  def document_params
    params.require(:document).permit(:name, :content)
  end

end
