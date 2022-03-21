class StandardComplicationsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @standard_complications = pagy(StandardComplication.includes(:standard_repair).all)
  rescue Pagy::OverflowError
    redirect_to standard_complications_url
  end

  def show
    @standard_complication = StandardComplication.includes(:standard_repair).find(params[:id])
  end

  def new
    @standard_complication = StandardComplication.new(standard_repair_id: params[:standard_repair_id])
    @standard_repairs = StandardRepair.all
  end

  def edit
    @standard_complication = StandardComplication.find(params[:id])
    @standard_repairs = StandardRepair.all
  end

  def create
    @standard_complication = StandardComplication.new(standard_complication_params)
    respond_to do |format|
      if @standard_complication.save
        format.html { redirect_to @standard_complication.standard_repair, notice: "Standard complication was successfully created." }
        format.json { render :show, status: :created, location: @standard_complication }
      else
        @standard_repairs = StandardRepair.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @standard_complication.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @standard_complication = StandardComplication.find(params[:id])
    respond_to do |format|
      if @standard_complication.update(standard_complication_params)
        format.html { redirect_to @standard_complication, notice: "Standard complication was successfully updated." }
        format.json { render :show, status: :ok, location: @standard_complication }
      else
        @standard_repairs = StandardRepair.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @standard_complication.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @standard_complication = StandardComplication.find(params[:id])
    respond_to do |format|
      if @standard_complication.destroy
        format.html { redirect_to standard_complications_url, notice: "Standard complication was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to @standard_complication, alert: 'Cannot delete this standard complication.' }
        format.json { render json: @standard_complication.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def standard_complication_params
      params.require(:standard_complication).permit(:name, :price, :standard_repair_id)
    end

end
