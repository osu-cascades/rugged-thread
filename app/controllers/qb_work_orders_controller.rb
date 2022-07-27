class QbWorkOrdersController < QuickbooksAbstractController

  def show
    @work_order = WorkOrder.find(params[:id])
    @item = Item.new(work_order: @work_order)
    @items = @work_order.items
    @brands = Brand.kept
    @item_statuses = ItemStatus.kept
    @item_types = ItemType.kept

    customer_id = @work_order.customer.id
    @customer = qb_request do
      Quickbooks::Customer.new(qb_api.get(:customer, customer_id))
    end

  end

end
