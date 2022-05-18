 class WorkOrdersController < ApplicationController
  include Pagy::Backend
  before_action :set_work_order, only: %i[ update destroy archive recover ]

  def index
    if params[:show_archive] == 'true'
      @pagy, @work_orders = pagy(WorkOrder.joins(:customer).where('work_orders.discarded_at IS NOT NULL AND (work_orders.number ILIKE ? OR customers.last_name ILIKE ?)', "%#{params[:query]}%", "%#{params[:query]}%").order(due_date: :asc))
    elsif params[:status] == 'invoiced'
      @pagy, @work_orders = pagy(WorkOrder.invoiced.joins(:customer).kept.where('number ILIKE ? OR customers.last_name ILIKE ?', "%#{params[:query]}%", "%#{params[:query]}%").order(due_date: :asc))
    else
      @pagy, @work_orders = pagy(WorkOrder.joins(:customer).kept.where('number ILIKE ? OR customers.last_name ILIKE ?', "%#{params[:query]}%", "%#{params[:query]}%").order(due_date: :asc))
    end
  rescue Pagy::OverflowError
    redirect_to work_orders_url
  end

  def show
    @work_order = WorkOrder.find(params[:id])
    @item = Item.new(work_order: @work_order)
    @items = @work_order.items
    @brands = Brand.all
    @item_statuses = ItemStatus.all
    @item_types = ItemType.all
  end

  def print
    @work_order = WorkOrder.includes(
      :creator,
      :customer,
      {items: [{repairs: [:standard_repair]}, {discounts: [:standard_discount]}, {fees: [:standard_fee]}]},
      ).find(params[:id])
    render 'print', layout: false
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
        format.html { redirect_to work_orders_url, alert: 'This work order cannot be deleted, it still has items associated with it.' }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @work_order = WorkOrder.find(params[:id])
    respond_to do |format|
      if @work_order.discard
        format.html { redirect_to work_orders_url, notice: "Work order was successfully archived." }
        format.json { head :no_content }
      else
        format.html { redirect_to work_orders_url, alert: 'Cannot archive this work order.' }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def recover
    respond_to do |format|
      if @work_order.undiscard
        format.html { redirect_to work_orders_url, notice: "Work Order was successfully recovered." }
        format.json { head :no_content }
      else
        format.html { redirect_to work_orders_url, alert: 'Cannot recover this work_order.' }
        format.json { render json: @work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_work_order
      @work_order = WorkOrder.find(params[:id])
    end

    def work_order_params
      params.require(:work_order).permit(:creator_id, :in_date, :due_date, :shipping, :customer_id)
    end

end
