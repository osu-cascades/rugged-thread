require "pagy/extras/array"

class QuickbooksCustomersController < QuickbooksAbstractController

  include Pagy::Backend

  # List of customers
  def index
    qb_request(lambda {
      customer_data = []
      qb_api.all(:customers).each do |customer|
        # Because Quickbook's SQL is so limited, we have to filter the results manually
        # See: https://developer.intuit.com/app/developer/qbo/docs/learn/explore-the-quickbooks-online-api/data-queries
        customer = Quickbooks::Customer.new(customer)
        if customer.full_name.downcase.include? params[:query] || "" then
          customer_data.push customer
        end
      end
      @pagy, @customers = pagy_array(customer_data)
    }, auth_redirect_path: request.original_fullpath)
  end

  # Single customer
  def show
    qb_request(lambda {
      @customer = Quickbooks::Customer.new(qb_api.get(:customer, params["id"]))
    }, auth_redirect_path: request.original_fullpath)
  end

  def new
    @customer = Quickbooks::Customer.new({})
    @customer_types = qb_request(lambda {
      Quickbooks.fix_response(qb_api.all(:customertype)).map do |type|
        Quickbooks::CustomerType.new(type)
      end
    }, auth_redirect_path: request.original_fullpath)
    puts
  end

end
