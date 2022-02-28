class StandardInventoryItemsController < ApplicationController
  before_action :set_standard_inventory_item, only: %i[ show edit update destroy ]

  def index
    @standard_inventory_items = StandardInventoryItem.all
  end

  def show
  end

  def new
    @standard_inventory_item = StandardInventoryItem.new
  end

  def edit
  end

  def create
    @standard_inventory_item = StandardInventoryItem.new(standard_inventory_item_params)

    respond_to do |format|
      if @standard_inventory_item.save
        format.html { redirect_to @standard_inventory_item, notice: "Standard Inventory Item was successfully created." }
        format.json { render :show, status: :created, location: @standard_inventory_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @standard_inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @standard_inventory_item.update(standard_inventory_item_params)
        format.html { redirect_to @standard_inventory_item, notice: "Standard Inventory Item was successfully updated." }
        format.json { render :show, status: :ok, location: @standard_inventory_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @standard_inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @standard_inventory_item.destroy
    respond_to do |format|
      format.html { redirect_to standard_inventory_items_url, notice: "Standard Inventory Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_standard_inventory_item
      @standard_inventory_item = StandardInventoryItem.find(params[:id])
    end

    def standard_inventory_item_params
      params.require(:standard_inventory_item).permit(:name, :sku, :price)
    end
end
