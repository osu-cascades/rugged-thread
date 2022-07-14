require "quickbooks_customer"

class QuickbooksCustomersController < QuickbooksAbstractController

  def show
    qb_request(lambda {
      qbo_data = QuickbooksSession.first
      qbo_api = QboApi.new(access_token: qbo_data["access_token"], realm_id: qbo_data["realm_id"])
      @customer = QuickbooksCustomer.new(qbo_api.get(:customer, params["id"]))
    }, auth_redirect_path: request.original_fullpath)
  end

end
