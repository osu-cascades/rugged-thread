class RepairsController < ApplicationController

  def index
    @repairs = @item.repairs
  end

  def show
    @repair = Repair.find(params[:id])
  end

  def new
    @item = Item.find(params[:item_id])
    @repair = @item.repairs.build
  end

  def edit
    @repair = Repair.find(params[:id])
  end

  def create
    @item = Item.find(params[:item_id])
    @repair = @item.repairs.build(repair_params)

    respond_to do |format|
      if @repair.save
        format.html { redirect_to @item, notice: "Repair was successfully created." }
        format.json { render :show, status: :created, location: @repair }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @repair = Repair.find(params[:id])
    respond_to do |format|
      if @repair.update(repair_params)
        format.html { redirect_to @repair.item, notice: "Repair was successfully updated." }
        format.json { render :show, status: :ok, location: @repair }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @repair = Repair.find(params[:id])
    @repair.destroy
    respond_to do |format|
      format.html { redirect_to item_path(@repair.item), notice: 'Repair was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def repair_params
      params.require(:repair).permit(:item_id, :standard_repair_id, :notes, :price)
    end

end
