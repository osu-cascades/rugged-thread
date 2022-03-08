class DiscountsController < ApplicationController

  def index
    @discounts = Discount.includes(:standard_discount).all
  end

  def show
    @discount = Discount.includes(
      :standard_discount,
      {item: [:work_order, :brand, :item_type]}
    ).find(params[:id])
  end

  def edit
    @discount = Discount.includes(:item).find(params[:id])
    @standard_discounts = StandardDiscount.all
  end

  def create
    @item = Item.find(params[:item_id])
    @discount = @item.discounts.build(discount_params)
    respond_to do |format|
      if @discount.save
        format.html { redirect_to @item, notice: "Discount was successfully created." }
        format.json { render :show, status: :created, location: @discount }
      else
        @item = Item.includes(
          :brand,
          :item_status,
          :item_type,
          {discounts: [:standard_discount]},
          {fees: [:standard_fee]},
          {repairs: [:standard_repair]},
          {work_order: [:creator, {customer: [:customer_type]}]},
          ).find(params[:item_id])
        @repair = Repair.new
        @fee = Fee.new
        @standard_discounts = StandardDiscount.all
        @standard_repairs = StandardRepair.all
        @standard_fees = StandardFee.all
        format.html { render 'items/show', status: :unprocessable_entity }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @discount = Discount.find(params[:id])
    respond_to do |format|
      if @discount.update(discount_params)
        format.html { redirect_to @discount, notice: "Discount was successfully updated." }
        format.json { render :show, status: :ok, location: @discount }
      else
        @standard_discounts = StandardDiscount.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discount = Discount.find(params[:id])
    respond_to do |format|
      if @discount.destroy
        format.html { redirect_to item_path(@discount.item), notice: 'Discount was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @discount, alert: 'Cannot delete this discount.' }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def discount_params
      params.require(:discount).permit(:item_id, :standard_discount_id, :percentage_amount, :price)
    end

end
