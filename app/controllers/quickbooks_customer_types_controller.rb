class QuickbooksCustomerTypesController < QuickbooksAbstractController

  def show
    qb_request do
      @customer_type = Quickbooks::CustomerType.from_id(params["id"])
      @customers = @customer_type.customers_with_type
    end
  end

end
