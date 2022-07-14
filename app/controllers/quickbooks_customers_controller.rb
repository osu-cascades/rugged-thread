require "quickbooks_customer"

class QuickbooksCustomersController < QuickbooksAbstractController

  def show
    qb_request(lambda {
      @customer = QuickbooksCustomer.new(qb_api.get(:customer, params["id"]))
    }, auth_redirect_path: request.original_fullpath)
  end

end
