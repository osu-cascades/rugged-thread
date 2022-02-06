class ComplicationTypesController < ApplicationController
  before_action :set_complication_type, only: %i[ show edit update destroy ]

  # GET /complication_types or /complication_types.json
  def index
    @complication_types = ComplicationType.all
  end

  # GET /complication_types/1 or /complication_types/1.json
  def show
  end

  # GET /complication_types/new
  def new
    @complication_type = ComplicationType.new
  end

  # GET /complication_types/1/edit
  def edit
  end

  # POST /complication_types or /complication_types.json
  def create
    @complication_type = ComplicationType.new(complication_type_params)

    respond_to do |format|
      if @complication_type.save
        format.html { redirect_to @complication_type, notice: "Complication type was successfully created." }
        format.json { render :show, status: :created, location: @complication_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @complication_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /complication_types/1 or /complication_types/1.json
  def update
    respond_to do |format|
      if @complication_type.update(complication_type_params)
        format.html { redirect_to @complication_type, notice: "Complication type was successfully updated." }
        format.json { render :show, status: :ok, location: @complication_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @complication_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /complication_types/1 or /complication_types/1.json
  def destroy
    @complication_type.destroy
    respond_to do |format|
      format.html { redirect_to complication_types_url, notice: "Complication type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complication_type
      @complication_type = ComplicationType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def complication_type_params
      params.require(:complication_type).permit(:description)
    end
end
