class RepairsController < ApplicationController
  before_action :set_repair, only: %i[ show edit update destroy ]

  # GET /repairs or /repairs.json
  def index
    @repairs = Repair.all
  end

  # GET /repairs/1 or /repairs/1.json
  def show
  end

  # GET /repairs/new
  def new
    @repair = Repair.new
  end

  # GET /repairs/1/edit
  def edit
  end

  # POST /repairs or /repairs.json
  def create
    @repair = Repair.new(repair_params)

    respond_to do |format|
      if @repair.save
        format.html { redirect_to @repair, notice: "Repair was successfully created." }
        format.json { render :show, status: :created, location: @repair }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repairs/1 or /repairs/1.json
  def update
    respond_to do |format|
      if @repair.update(repair_params)
        format.html { redirect_to @repair, notice: "Repair was successfully updated." }
        format.json { render :show, status: :ok, location: @repair }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repairs/1 or /repairs/1.json
  def destroy
    @repair.destroy
    respond_to do |format|
      format.html { redirect_to repairs_url, notice: "Repair was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repair
      @repair = Repair.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repair_params
      params.require(:repair).permit(:charge, :quote, :time_total, :shop_rate, :item_number, :number, :technician_id, :notes, :time, :date)
    end
end
