class FeesController < ApplicationController

  def index
    @fees = Fee.includes(:standard_fee).all
  end

  def show
    @fee = Fee.includes(
      :standard_fee,
      {item: [:work_order, :brand, :item_type]}
    ).find(params[:id])
  end

  def edit
    @fee = Fee.includes(:item).find(params[:id])
    @standard_fees = StandardFee.all
  end

  def create
    @item = Item.find(params[:item_id])
    @fee = @item.fees.build(fee_params)
    respond_to do |format|
      if @fee.save
        format.html { redirect_to @item, notice: "Fee was successfully created." }
        format.json { render :show, status: :created, location: @fee }
      else
        @item = Item.includes(
          :brand,
          :item_status,
          :item_type,
          {fees: [:standard_fee]},
          {discounts: [:standard_discount]},
          {repairs: [:standard_repair]},
          {work_order: [:creator, {customer: [:customer_type]}]},
        ).find(params[:item_id])
        @repair = Repair.new
        @discount = Discount.new
        @standard_fees = StandardFee.all
        @standard_discounts = StandardDiscount.all
        @standard_repairs = StandardRepair.all
        format.html { render 'items/show', status: :unprocessable_entity }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @fee = Fee.find(params[:id])
    respond_to do |format|
      if @fee.update(fee_params)
        format.html { redirect_to @fee, notice: "Fee was successfully updated." }
        format.json { render :show, status: :ok, location: @fee }
      else
        @standard_fees = StandardFee.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fee = Fee.find(params[:id])
    respond_to do |format|
      if @fee.destroy
        format.html { redirect_to item_path(@fee.item), notice: 'Fee was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @fee, alert: 'Cannot delete this fee.' }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def fee_params
      params.require(:fee).permit(:item_id, :standard_fee_id, :price)
    end

end
