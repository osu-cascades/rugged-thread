require "quickbooks_customer"

class QuickbooksCustomersController < QuickbooksAbstractController

  # List of customers
  def index
    qb_request(lambda {
      @customers = []
      customers_data = qb_api.all(:customers).each do |customer|
        @customers.push QuickbooksCustomer.new(customer)
      end
    }, auth_redirect_path: request.original_fullpath)
  end

  # Single customer
  def show
    qb_request(lambda {
      @customer = QuickbooksCustomer.new(qb_api.get(:customer, params["id"]))
    }, auth_redirect_path: request.original_fullpath)
  end

end
