class InvoicesController < QuickbooksAbstractController

  def show
    @work_order = WorkOrder.find(params[:id])
  end

  def submit
    work_order = WorkOrder.find(params[:id])
    item = work_order.items.first

    invoice = Quickbooks::Invoice.new
    invoice.set_customer(work_order.customer_id)

    work_order.items.each do |item|
      invoice.add_line(item: item.id, amount: item.price.to_i, description: item.item_type.name)
    end

    invoice.assign_doc_number

    qb_request do
      logger.info "\n\n\n#{invoice.payload.to_s}\n\n\n"
      response = qb_api.create(:invoice, payload: invoice.payload)
      redirect_to "https://app.qbo.intuit.com/app/invoice?txnId=#{response["Id"]}", allow_other_host: true
    end
  end

end
