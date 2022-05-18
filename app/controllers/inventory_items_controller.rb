class InventoryItemsController < ApplicationController
  
  def index
    @inventory_items = InventoryItem.includes(:standard_inventory_item).all
  end

  def show
    @inventory_item = InventoryItem.includes(:standard_inventory_item, :repair).find(params[:id])
  end

  def edit
    @inventory_item = InventoryItem.includes(:repair).find(params[:id])
    @standard_inventory_items = StandardInventoryItem.kept
  end

  def create
    @repair = Repair.find(params[:repair_id])
    @inventory_item = @repair.inventory_items.build(inventory_item_params)
    respond_to do |format|
      if @inventory_item.save
        format.html { redirect_to @repair, notice: "Inventory Item was successfully created." }
        format.json { render :show, status: :created, location: @inventory_item }
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
        @standard_inventory_items = StandardInventoryItem.kept
        @standard_complications = @repair.standard_repair.standard_complications.kept
        @special_order_item = SpecialOrderItem.new
        format.html { render 'repairs/show', status: :unprocessable_entity }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @inventory_item = InventoryItem.find(params[:id])
    respond_to do |format|
      if @inventory_item.update(inventory_item_params)
        format.html { redirect_to @inventory_item, notice: "Inventory Item was successfully updated." }
        format.json { render :show, status: :ok, location: @inventory_item }
      else
        @standard_inventory_items = StandardInventoryItem.kept
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inventory_item = InventoryItem.find(params[:id])
    respond_to do |format|
      if @inventory_item.destroy
        format.html { redirect_to repair_path(@inventory_item.repair), notice: 'Inventory Item was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @inventory_item, alert: 'Cannot delete this inventory item.' }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def inventory_item_params
      params.require(:inventory_item).permit(:repair_id, :standard_inventory_item_id, :price)
    end

end
