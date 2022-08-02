class InvoicesController < QuickbooksAbstractController

  # Create invoices from multiple items
  def index
    @customers = qb_request do
      qb_api.all(:customer).map do |c|
        Quickbooks::Customer.new(c)
      end
    end
  end

  # An invoice created from a single work order
  def show
    redirect_to invoices_preview_path(from_work_order: params[:id])
  end

  def preview
    if params[:from_work_order].present?
      work_order = WorkOrder.find(params[:from_work_order])
      @items = work_order.items
      @customer = qb_request do
        Quickbooks::Customer.new(qb_api.get(:customer, work_order.customer_id))
      end
    end
  end

  def submit
    invoice = Quickbooks::Invoice.new
    items = (params[:items] || []).map! do |item_id|
      Item.find(item_id)
    end

    invoice.set_customer(params[:customer_id])
    items.each do |item|
      invoice.add_item(item)
    end
    invoice.assign_doc_number

    qb_request do
      logger.info invoice.payload.to_s
      response = qb_api.create(:invoice, payload: invoice.payload)
      items.each do |item|
        item.qb_invoice_id = response["Id"]
        item.save
      end
      redirect_to "https://app.qbo.intuit.com/app/invoice?txnId=#{response["Id"]}", allow_other_host: true
    end
  end

end
