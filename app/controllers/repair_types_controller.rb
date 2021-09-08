class RepairTypesController < ApplicationController
  before_action :set_repair_type, only: %i[ show edit update destroy ]

  # GET /repair_types or /repair_types.json
  def index
    @repair_types = RepairType.all
  end

  # GET /repair_types/1 or /repair_types/1.json
  def show
  end

  # GET /repair_types/new
  def new
    @repair_type = RepairType.new
  end

  # GET /repair_types/1/edit
  def edit
  end

  # POST /repair_types or /repair_types.json
  def create
    @repair_type = RepairType.new(repair_type_params)

    respond_to do |format|
      if @repair_type.save
        format.html { redirect_to @repair_type, notice: "Repair type was successfully created." }
        format.json { render :show, status: :created, location: @repair_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repair_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repair_types/1 or /repair_types/1.json
  def update
    respond_to do |format|
      if @repair_type.update(repair_type_params)
        format.html { redirect_to @repair_type, notice: "Repair type was successfully updated." }
        format.json { render :show, status: :ok, location: @repair_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repair_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repair_types/1 or /repair_types/1.json
  def destroy
    @repair_type.destroy
    respond_to do |format|
      format.html { redirect_to repair_types_url, notice: "Repair type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repair_type
      @repair_type = RepairType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repair_type_params
      params.require(:repair_type).permit(:name, :time_estimate)
    end
end
