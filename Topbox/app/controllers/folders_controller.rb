class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_mytopbox, only: [:index]
  helper_method :full_path

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


  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create

    puts
    puts "deu quase aguia bb"
    puts

    @parent = params.require(:folder).require(:parent)
    @folder = Folder.new(folder_params)
    respond_to do |format|
      @folder.parent = Folder.find(@parent)
      @folder.owner = current_user
      if @folder.save
        format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
        format.json { render :show, status: :created, location: @folder }
      else
        puts
        puts "deu aguia bb"
        puts
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end

    puts
    puts "entrei bb"
    puts

  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
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
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to folders_url, notice: 'Folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  public
  def full_path(folder)
    full_path = ''
    parent = folder.parent
    until (parent.nil?)
      full_path = (parent.name + '/' + full_path)
      parent = parent.parent
    end
    return full_path
  end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :description)
    end



end