class StandardDiscountsController < ApplicationController
  before_action :set_standard_discount, only: %i[ show edit update destroy ]

  # GET /standard_discounts or /standard_discounts.json
  def index
    @standard_discounts = StandardDiscount.all
  end

  # GET /standard_discounts/1 or /standard_discounts/1.json
  def show
  end

  # GET /standard_discounts/new
  def new
    @standard_discount = StandardDiscount.new
  end

  # GET /standard_discounts/1/edit
  def edit
  end

  # POST /standard_discounts or /standard_discounts.json
  def create
    @standard_discount = StandardDiscount.new(standard_discount_params)

    respond_to do |format|
      if @standard_discount.save
        format.html { redirect_to @standard_discount, notice: "Standard Discount was successfully created." }
        format.json { render :show, status: :created, location: @standard_discount }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @standard_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /standard_discounts/1 or /standard_discounts/1.json
  def update
    respond_to do |format|
      if @standard_discount.update(standard_discount_params)
        format.html { redirect_to @standard_discount, notice: "Standard Discount was successfully updated." }
        format.json { render :show, status: :ok, location: @standard_discount }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @standard_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /standard_discounts/1 or /standard_discounts/1.json
  def destroy
    @standard_discount.destroy
    respond_to do |format|
      format.html { redirect_to standard_discounts_url, notice: "Standard Discount was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standard_discount
      @standard_discount = StandardDiscount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def standard_discount_params
      params.require(:standard_discount).permit(:name, :percentage_amount, :dollar_amount)
    end
end