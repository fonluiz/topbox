class PrivaciesController < ApplicationController
  before_action :set_privacy, only: [:show, :edit, :update, :destroy]

  # GET /privacies
  # GET /privacies.json
  def index
    @privacies = Privacy.all
  end

  # GET /privacies/1
  # GET /privacies/1.json
  def show
  end

  # GET /privacies/new
  def new
    @privacy = Privacy.new
  end

  # GET /privacies/1/edit
  def edit
  end

  def switch_visibility
    document = Document.find(params[:id])
    @privacy = document.privacy
    if @privacy.visibility == "open"
      @privacy.update visibility: "closed"
    else
      @privacy.update visibility: "open"
    end
    redirect_to document
  end

  # POST /privacies
  # POST /privacies.json
  def create
    @privacy = Privacy.new(privacy_params)

    respond_to do |format|
      if @privacy.save
        format.html { redirect_to @privacy, notice: 'Privacy was successfully created.' }
        format.json { render :show, status: :created, location: @privacy }
      else
        format.html { render :new }
        format.json { render json: @privacy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /privacies/1
  # PATCH/PUT /privacies/1.json
  def update
    respond_to do |format|
      if @privacy.update(privacy_params)
        format.html { redirect_to @privacy, notice: 'Privacy was successfully updated.' }
        format.json { render :show, status: :ok, location: @privacy }
      else
        format.html { render :edit }
        format.json { render json: @privacy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /privacies/1
  # DELETE /privacies/1.json
  def destroy
    @privacy.destroy
    respond_to do |format|
      format.html { redirect_to privacies_url, notice: 'Privacy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_privacy
      @privacy = Privacy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def privacy_params
      params.require(:privacy).permit(:document_id)
    end
end
