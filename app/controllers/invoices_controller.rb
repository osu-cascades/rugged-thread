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
    @work_order = WorkOrder.find(params[:id])
  end

  def submit
    work_order = WorkOrder.find(params[:id])

    invoice = Quickbooks::Invoice.new
    invoice.set_customer(work_order.customer_id)

    work_order.items.each do |item|
      # TODO: Figure out how the invoice should be formatted
      invoice.add_line(item: 1, amount: item.price.to_i, description: "#{item.brand.name} #{item.item_type.name}")
    end

    invoice.assign_doc_number

    qb_request do
      response = qb_api.create(:invoice, payload: invoice.payload)
      work_order.items.each do |item|
        item.qb_invoice_id = response["Id"]
        item.save
      end
      redirect_to "https://app.qbo.intuit.com/app/invoice?txnId=#{response["Id"]}", allow_other_host: true
    end
  end

end
