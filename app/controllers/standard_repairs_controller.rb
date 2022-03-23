class StandardRepairsController < ApplicationController
  include Pagy::Backend

  before_action :set_standard_repair, only: %i[ edit update destroy ]

  def index
    @pagy, @standard_repairs = pagy(StandardRepair.where('name ILIKE ? OR method ILIKE ? OR description ILIKE ?', "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%").order(name: :asc))
  rescue Pagy::OverflowError
    redirect_to standard_repairs_url
  end

  def show
    @standard_repair = StandardRepair.find(params[:id])
    @standard_complications = @standard_repair.standard_complications
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

  def destroy
    respond_to do |format|
      if @standard_repair.destroy
        format.html { redirect_to standard_repairs_url, notice: "Standard repair was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to @standard_repair, alert: 'Cannot delete this standard repair.' }
        format.json { render json: @standard_repair.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_standard_repair
      @standard_repair = StandardRepair.find(params[:id])
    end

    def standard_repair_params
      params.require(:standard_repair).permit(:name, :method, :description, :level, :price)
    end

end
