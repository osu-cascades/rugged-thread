require "quickbooks"

class QuickbooksCustomersController < QuickbooksAbstractController

  # List of customers
  def index
    qb_request(lambda {
      @customers = []
      customers_data = qb_api.all(:customers).each do |customer|
        @customers.push Quickbooks::Customer.new(customer)
      end
    }, auth_redirect_path: request.original_fullpath)
  end

  # Single customer
  def show
    qb_request(lambda {
      @customer = Quickbooks::Customer.new(qb_api.get(:customer, params["id"]), self)
    }, auth_redirect_path: request.original_fullpath)
  end

end
