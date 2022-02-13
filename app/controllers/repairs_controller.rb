class RepairsController < ApplicationController

  def index
    @repairs = Repair.includes(:standard_repair).all
  end

  def show
    @repair = Repair.includes(
      :standard_repair,
      {item: [:work_order, :brand, :item_type]}
    ).find(params[:id])
  end

  def edit
    @repair = Repair.includes(:item).find(params[:id])
    @standard_repairs = StandardRepair.all
  end

  def create
    @item = Item.find(params[:item_id])
    @repair = @item.repairs.build(repair_params)
    respond_to do |format|
      if @repair.save
        format.html { redirect_to @item, notice: "Repair was successfully created." }
        format.json { render :show, status: :created, location: @repair }
      else
        @item = Item.includes(
          :brand,
          :item_status,
          :item_type,
          {repairs: [:standard_repair]},
          {work_order: [:creator, {customer: [:customer_type]}]},
        ).find(params[:item_id])
        @standard_repairs = StandardRepair.all
        format.html { render 'items/show', status: :unprocessable_entity }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @repair = Repair.find(params[:id])
    respond_to do |format|
      if @repair.update(repair_params)
        format.html { redirect_to @repair, notice: "Repair was successfully updated." }
        format.json { render :show, status: :ok, location: @repair }
      else
        @standard_repairs = StandardRepair.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @repair = Repair.find(params[:id])
    respond_to do |format|
      if @repair.destroy
        format.html { redirect_to item_path(@repair.item), notice: 'Repair was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @repair, alert: 'Cannot delete this repair.' }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def repair_params
      params.require(:repair).permit(:item_id, :standard_repair_id, :notes, :price)
    end

end
