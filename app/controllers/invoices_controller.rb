class InvoicesController < QuickbooksAbstractController

  def show
    @work_order = WorkOrder.find(params[:id])
  end

  def submit
    work_order = WorkOrder.find(params[:id])
    item = work_order.items.first
    now = DateTime.now

    invoice_number = InvoiceNumbers.first || InvoiceNumbers.create(year: now.year, month: now.month, number: 0)
    invoice_number.number += 1
    # Reset number to 1 on a new month
    if invoice_number.year != now.year || invoice_number.month != now.month
      invoice_number.number = 1
      invoice_number.year = now.year
      invoice_number.month = now.month
    end
    invoice_number.save

    payload = {
      "DocNumber" => "#{now.year % 100}#{now.month.to_s.rjust(2, "0")}#{invoice_number.number.to_s.rjust(4, "0")}",
      "CustomerRef" => {
        # TODO: Replace with dynamic/correct id when customer/quickbooks integration is more flushed out
        "value" => "1"
      },
      # Basic invoice with 1 item
      "Line" => [{
        "DetailType" => "SalesItemLineDetail",
        "Description" => item.item_type.name,
        "Amount" => item.price.to_i,
        "SalesItemLineDetail" => {
          "ServiceDate" => "#{now.year}-#{now.month.to_s.rjust(2, "0")}-#{now.day.to_s.rjust(2, "0")}",
          "ItemRef" => {
            # TODO: Use Quickbooks to store Items, use that id here.
            "value" => 1
          }
        }
      }]
    }
    qb_request do
      logger.info "\n\n\n#{payload.to_s}\n\n\n"
      response = qb_api.create(:invoice, payload: payload)
      redirect_to "https://app.qbo.intuit.com/app/invoice?txnId=#{response["Id"]}", allow_other_host: true
    end
  end

end
