class SpecialOrderItemsController < ApplicationController
  def index
    @special_order_items = SpecialOrderItem.includes(:repair).all
  end

  def show
    @special_order_item = SpecialOrderItem.includes(:repair).find(params[:id])
  end

  def edit
    @special_order_item = SpecialOrderItem.includes(:repair).find(params[:id])
  end

  def create
    @repair = Repair.find(params[:repair_id])
    @special_order_item = @repair.special_order_items.build(special_order_item_params)
    respond_to do |format|
      if @special_order_item.save
        format.html { redirect_to @repair, notice: "Special Order Item was successfully created." }
        format.json { render :show, status: :created, location: @special_order_item }
      else
        @repair = Repair.includes(
          :standard_repair,
          :special_order_items,
          {inventory_items: [:standard_inventory_item]},
          {complications: [:standard_complication]},
          {item: [:work_order, :brand, :item_type]}
        ).find(params[:repair_id])
        @complication = Complication.new(repair: @repair)
        @repairs = Repair.includes(:standard_repair).all
        @standard_complications = @repair.standard_repair.standard_complications
        @inventory_item = InventoryItem.new
        @standard_inventory_items = StandardInventoryItem.all
        format.html { render 'repairs/show', status: :unprocessable_entity }
        format.json { render json: @special_order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @special_order_item = SpecialOrderItem.find(params[:id])
    respond_to do |format|
      if @special_order_item.update(special_order_item_params)
        format.html { redirect_to @special_order_item, notice: "Special Order Item was successfully updated." }
        format.json { render :show, status: :ok, location: @special_order_item }
      else
    
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @special_order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @special_order_item = SpecialOrderItem.find(params[:id])
    respond_to do |format|
      if @special_order_item.destroy
        format.html { redirect_to repair_path(@special_order_item.repair), notice: 'Special Order Item was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @special_order_item, alert: 'Cannot delete this inventory item.' }
        format.json { render json: @special_order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def special_order_item_params
      params.require(:special_order_item).permit(:repair_id, :name, :price)
    end
end
