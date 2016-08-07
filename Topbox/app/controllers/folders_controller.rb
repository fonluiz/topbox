class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_mytopbox, only: [:index]
  helper_method :full_path
  helper_method :default_create_folder

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

  # POST /folders
  # POST /folders.json
  def create
    @parent = params.require(:folder).require(:parent)
    @folder = Folder.new(folder_params)
    respond_to do |format|
      @folder.parent = Folder.find(@parent)
      if @folder.save
        format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /folders/1/edit
  def edit
    set_current_folder(@folder)
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    @parent = params.require(:folder).require(:parent)
    respond_to do |format|
      @folder.parent = Folder.find(@parent)
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
    parent = @folder.parent
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to parent, action: :show, notice: 'Folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def default_create_folder
    @folder_new = Folder.new
    @folder_new.name = "Nova Pasta"
    @folder_new.parent = current_folder
    @folder_new.user = current_user

    if @folder_new.save
      redirect_to '/mytopbox/'+current_folder.id.to_s
    else
      redirect_to '/mytopbox/'
    end

  end

  public
  def full_path(folder)
    full_path = folder.name
    divider = '<b style="color: #2251A6">  >  </b>'
    parent_folder = folder.parent
    until (parent_folder.nil?)
      full_path = (parent_folder.name + divider + full_path)
      parent_folder = parent_folder.parent
    end
    return full_path.html_safe
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_folder
      @folder = Folder.find(params[:id])
    end

    def folder_params
      params.require(:folder).permit(:name)
    end

end