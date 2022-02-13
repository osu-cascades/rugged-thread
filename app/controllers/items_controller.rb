class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.includes(
      :brand,
      :item_status,
      :item_type,
      {repairs: [:standard_repair]},
      {work_order: [:creator, {customer: [:customer_type]}]},
      ).find(params[:id])
    @repair = Repair.new
    @standard_repairs = StandardRepair.all
  end

  def edit
    @item = Item.find(params[:id])
    @brands = Brand.all
    @item_statuses = ItemStatus.all
    @item_types = ItemType.all
  end

  def create
    @work_order = WorkOrder.find(params[:work_order_id])
    @item = @work_order.items.build(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @work_order, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        @work_order.items.reset
        @items = @work_order.items
        @brands = Brand.all
        @item_statuses = ItemStatus.all
        @item_types = ItemType.all
        format.html { render 'work_orders/show', status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        @brands = Brand.all
        @item_statuses = ItemStatus.all
        @item_types = ItemType.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.destroy
        format.html { redirect_to work_order_path(@item.work_order), notice: 'Item was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @item, alert: 'Cannot delete this item.' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def item_params
      params.require(:item).permit(:due_date, :notes, :brand_id, :work_order_id, :item_type_id, :item_status_id)
    end

end
