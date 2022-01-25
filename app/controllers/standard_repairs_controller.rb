class StandardRepairsController < ApplicationController
  before_action :set_standard_repair, only: %i[ show edit update destroy ]

  # GET /standard_repairs or /standard_repairs.json
  def index
    @standard_repairs = StandardRepair.all
  end

  # GET /standard_repairs/1 or /standard_repairs/1.json
  def show
  end

  # GET /standard_repairs/new
  def new
    @standard_repair = StandardRepair.new
  end

  # GET /standard_repairs/1/edit
  def edit
  end

  # POST /standard_repairs or /standard_repairs.json
  def create
    @standard_repair = StandardRepair.new(standard_repair_params)

    respond_to do |format|
      if @standard_repair.save
        format.html { redirect_to @standard_repair, notice: "Standard repair was successfully created." }
        format.json { render :show, status: :created, location: @standard_repair }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @standard_repair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /standard_repairs/1 or /standard_repairs/1.json
  def update
    respond_to do |format|
      if @standard_repair.update(standard_repair_params)
        format.html { redirect_to @standard_repair, notice: "Standard repair was successfully updated." }
        format.json { render :show, status: :ok, location: @standard_repair }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @standard_repair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /standard_repairs/1 or /standard_repairs/1.json
  def destroy
    @standard_repair.destroy
    respond_to do |format|
      format.html { redirect_to standard_repairs_url, notice: "Standard repair was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standard_repair
      @standard_repair = StandardRepair.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def standard_repair_params
      params.require(:standard_repair).permit(:name, :sub_repair, :method, :complications, :description, :charge, :fee_type)
    end
end
