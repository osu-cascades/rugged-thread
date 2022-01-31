class ItemsController < ApplicationController
  before_action :get_work_order
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  
  # GET /items or /items.json
  def index
    @items = @work_order.items
  end

  def show
    @item = @work_order.items.find(params[:id])
  end

  # GET /items/new
  def new
    @item = @work_order.items.build
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
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

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @work_order, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to work_order_path(@work_order), notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def get_work_order
      @work_order = WorkOrder.find(params[:work_order_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @work_order = WorkOrder.find(params[:work_order_id])
      @item = @work_order.items.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:due_date, :estimate, :labor_estimate, :notes, :brand_id, :work_order_id, :item_type_id, :item_status_id)
    end
end
