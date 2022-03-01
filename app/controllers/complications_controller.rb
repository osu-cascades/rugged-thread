class ComplicationsController < ApplicationController

  def index
    @complications = Complication.includes(:standard_complication, :repair).all
  end

  def show
    @complication = Complication.includes(:standard_complication, :repair).find(params[:id])
  end

  def create
    @repair = Repair.find(params[:repair_id])
    @complication = @repair.complications.build(complication_params)
    respond_to do |format|
      if @complication.save
        format.html { redirect_to @repair, notice: "Complication was successfully created." }
        format.json { render :show, status: :created, location: @complication }
      else
        @repair = Repair.includes(
          :standard_repair,
          :complications,
          {inventory_items: [:standard_inventory_item]},
          {item: [:work_order, :brand, :item_type]}
        ).find(params[:repair_id])
        @standard_complications = @repair.standard_repair.standard_complications
        @repairs = Repair.includes(:standard_repair).all
        @inventory_item = InventoryItem.new
        @standard_inventory_items = StandardInventoryItem.all
        format.html { render 'repairs/show', status: :unprocessable_entity }
        format.json { render json: @complication.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @complication = Complication.includes(:standard_complication, :repair).find(params[:id])
    @standard_complications = @complication.repair.standard_repair.standard_complications
    @repairs = Repair.includes(:standard_repair).all
  end

  def update
    @complication = Complication.find(params[:id])
    respond_to do |format|
      if @complication.update(complication_params)
        format.html { redirect_to @complication, notice: "Complication was successfully updated." }
        format.json { render :show, status: :ok, location: @complication }
      else
        @standard_complications = @complication.repair.standard_repair.standard_complications
        @repairs = Repair.includes(:standard_repair).all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @complication.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @complication = Complication.find(params[:id])
    respond_to do |format|
      if @complication.destroy
        format.html { redirect_to repair_path(@complication.repair), notice: 'Complication was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @complication, alert: 'Cannot delete this complication.' }
        format.json { render json: @complication.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def complication_params
      params.require(:complication).permit(:repair_id, :standard_complication_id, :price)
    end

end
