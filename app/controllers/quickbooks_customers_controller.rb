require "pagy/extras/array"

class QuickbooksCustomersController < QuickbooksAbstractController

  include Pagy::Backend

  # List of customers
  def index
    qb_request do
      customer_data = []
      query = "SELECT * FROM Customer"
      if params["show_archive"]
        query += " WHERE Active = false"
      end
      qb_api.all(:customers, select: query).each do |customer|
        # Because Quickbook's SQL is so limited, we have to filter the results manually
        # See: https://developer.intuit.com/app/developer/qbo/docs/learn/explore-the-quickbooks-online-api/data-queries
        customer = Quickbooks::Customer.new(customer)
        if customer.full_name.downcase.include? (params[:query] || "").downcase then
          customer_data.push customer
        end
      end
      @pagy, @customers = pagy_array(customer_data)
    end
  end

  # Single customer
  def show
    @work_orders = WorkOrder.kept.where(customer: params["id"])
    qb_request do
      @customer = Quickbooks::Customer.new(qb_api.get(:customer, params["id"]))
    end
  end

  def new
    @customer = Quickbooks::Customer.new({})
    @customer_types = CustomerType.where.not("q_customer_type_id" => nil)
  end

  def create
    modify_validation(:new) do |format, data|
      response = qb_api.create(:customer, payload: data)
      format.html { redirect_to quickbooks_customer_path(response["Id"]), notice: "Customer was successfully created." }
      format.json { render :show, status: :ok, location: quickbooks_customer_path(response["Id"]) }
    end
  end

  def edit
    qb_request do
      @customer = Quickbooks::Customer.new(qb_api.get(:customer, params["id"]))
    end
    @customer_types = qb_request do
      @customer_types = CustomerType.where.not("q_customer_type_id" => nil)
    end
  end

  def update
    modify_validation(:edit) do |format, data|
      response = qb_api.update(:customer, id: params["id"], payload: data)
      format.html { redirect_to quickbooks_customer_path(params["id"]), notice: "Customer was successfully updated." }
      format.json { render :show, status: :ok, location: quickbooks_customer_path(params["id"]) }
    end
  end

  def modify_validation(render_location)
    @errors = []
    form_data = params["quickbooks_customers"]
    data = {
      "Id" => params["id"],
      "GivenName" => form_data["first_name"],
      "FamilyName" => form_data["last_name"],
      "PrimaryPhone" => {
        "FreeFormNumber" => form_data["phone_number"]
      },
      "AlternatePhone" => {
        "FreeFormNumber" => form_data["alternative_phone_number"]
      },
      "PrimaryEmailAddr" => {
        "Address" => form_data["email_address"]
      },
      "ShipAddr" => {
        "PostalCode" => form_data["shipping_zip_code"],
        "City" => form_data["shipping_city"],
        "Line1" => form_data["shipping_street_address"],
        "CountrySubDivisionCode" => form_data["shipping_state"],
        "Country" => form_data["shipping_country"] || "USA"
      },
      "BillAddr" => {
        "PostalCode" => form_data["billing_zip_code"],
        "City" => form_data["billing_city"],
        "Line1" => form_data["billing_street_address"],
        "CountrySubDivisionCode" => form_data["billing_state"],
        "Country" => form_data["billing_country"] || "USA"
      },
      "CompanyName" => form_data["business_name"],
      "CustomerTypeRef" => {
        "value" => form_data["customer_type_id"]
      }
    }
    @customer = Quickbooks::Customer.new(data)
    respond_to do |format|
      # Manual data validation
      phone_regex = /^(\+\d+\s?)?\(?\d{3}\)?\s?-?\s?\d{3}\s?-?\s?\d{4}$/
      if @customer.customer_type_id === ""
        @errors.push "Customer type must exist"
      end
      if @customer.phone_number != "" && !@customer.phone_number.match?(phone_regex)
        @errors.push "Phone number is an invalid number"
      end
      if @customer.alternative_phone_number != "" && !@customer.alternative_phone_number.match?(phone_regex)
        @errors.push "Alternate phone number is an invalid number"
      end
      if @errors.length > 0
        @customer_types = @customer_types = CustomerType.where.not("q_customer_type_id" => nil)
        format.html { render render_location, status: :unprocessable_entity }
        format.json { render json: e.message, status: :unprocessable_entity }
      else
        # Save to quickbooks
        begin
          qb_request do
            yield format, data
          end
        rescue QboApi::BadRequest => e
          @customer_types = @customer_types = CustomerType.where.not("q_customer_type_id" => nil)
          @errors.push e.message.match(/:error_detail=>"(.*?)"/)[1]
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: e.message, status: :unprocessable_entity }
        end
      end
    end
  end

  def archive
    respond_to do |format|
      qb_request do
        begin
          qb_api.deactivate(:customer, id: params["id"])
          format.html { redirect_to quickbooks_customers_path, notice: "Customer was successfully archived." }
          format.json { head :no_content }
        rescue QboApi::BadRequest => e
          logger.info e
          format.html { redirect_to quickbooks_customers_path, alert: "This customer could not be archived due to an error. Please try again later." }
          format.json { render json: e.message, status: :unprocessable_entity }
        end
      end
    end
  end

  def recover
    respond_to do |format|
      qb_request do
        data = {
          "Id" => params["id"],
          "sparse" => true,
          "Active" => true
        }
        begin
          qb_api.update(:customer, id: params["id"], payload: data)
          format.html { redirect_to quickbooks_customers_path, notice: "Customer was successfully recovered." }
          format.json { head :no_content }
        rescue QboApi::BadRequest => e
          logger.info e
          format.html { redirect_to quickbooks_customers_path, alert: "This customer could not be recovered due to an error. Please try again later." }
          format.json { render json: e.message, status: :unprocessable_entity }
        end
      end
    end
  end

end
