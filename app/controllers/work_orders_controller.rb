class WorkOrdersController < ApplicationController
  before_action :set_work_order, only: %i[ show edit update destroy ]

  # GET /work_orders or /work_orders.json
  def index
    @work_orders = WorkOrder.all
  end

  # GET /work_orders/1 or /work_orders/1.json
  def show
    @item = Item.new
    @items = @work_order.items
  end

  def new
    @work_order = WorkOrder.new(customer_id: params[:customer_id])
  end

  # GET /work_orders/1/edit
  def edit
  end

  # POST /work_orders or /work_orders.json
  def create
    @work_order = WorkOrder.new(work_order_params)

    respond_to do |format|
      if @work_order.save
        format.html { redirect_to @work_order, notice: "Work order was successfully created." }
        format.json { render :show, status: :created, location: @work_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_orders/1 or /work_orders/1.json
  def update
    respond_to do |format|
      if @work_order.update(work_order_params)
        format.html { redirect_to @work_order, notice: "Work order was successfully updated." }
        format.json { render :show, status: :ok, location: @work_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    respond_to do |format|
      if @work_order.destroy
        format.html { redirect_to work_orders_url, notice: "Work order was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to work_orders_url, alert: 'Cannot delete this work order.' }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_order
      @work_order = WorkOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def work_order_params
      params.require(:work_order).permit(:in_date, :shipping, :customer_id)
    end
end
