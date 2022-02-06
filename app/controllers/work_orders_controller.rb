class WorkOrdersController < ApplicationController

  def index
    @work_orders = WorkOrder.all
  end

  def show
    @work_order = WorkOrder.find(params[:id])
    @item = Item.new
    @items = @work_order.items
  end

  def new
    @work_order = current_user.created_work_orders.build(
      customer_id: params[:customer_id])
    @creators = User.all
    @customers = Customer.all
  end

  def edit
    @work_order = WorkOrder.find(params[:id])
    @creators = User.all
    @customers = Customer.all
  end

  def create
    @work_order = WorkOrder.new(work_order_params)
    respond_to do |format|
      if @work_order.save
        format.html { redirect_to @work_order, notice: "Work order was successfully created." }
        format.json { render :show, status: :created, location: @work_order }
      else
        @creators = User.all
        @customers = Customer.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @work_order = WorkOrder.find(params[:id])
    respond_to do |format|
      if @work_order.update(work_order_params)
        format.html { redirect_to @work_order, notice: "Work order was successfully updated." }
        format.json { render :show, status: :ok, location: @work_order }
      else
        @creators = User.all
        @customers = Customer.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work_order = WorkOrder.find(params[:id])
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

    def work_order_params
      params.require(:work_order).permit(:creator_id, :in_date, :shipping, :customer_id)
    end

end
