class ItemsController < ApplicationController

  def index
    @items = @work_order.items
  end

  def show
    @item = Item.find(params[:id])
    @repair = Repair.new
    @repairs = @item.repairs
  end

  def new
    @work_order = WorkOrder.find(params[:work_order_id])
    @item = @work_order.items.build
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @work_order = WorkOrder.find(params[:work_order_id])
    @item = @work_order.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @work_order, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item.work_order, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.html { redirect_to work_order_path(@item.work_order), notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def item_params
      params.require(:item).permit(:due_date, :notes, :brand_id, :work_order_id, :item_type_id, :item_status_id)
    end

end
