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
    })
  end

  # Single customer
  def show
    qb_request(lambda {
      @customer = Quickbooks::Customer.new(qb_api.get(:customer, params["id"]))
    })
  end

  def new
    @customer = Quickbooks::Customer.new({})
    @customer_types = qb_request(lambda {
      qb_api.all(:customer_type).map do |type|
        Quickbooks::CustomerType.new(type)
      end
    })
  end

  def create
    form_data = params["quickbooks_customers"]
    data = {
      "GivenName" => form_data["first_name"],
      "FamilyName" => form_data["last_name"],
      "PrimaryPhone" => {
        "FreeFormNumber" => form_data["phone_number"]
      },
      "AlternatePhone" => {
        "FreeFormNumber" => form_data["alternate_phone_number"]
      },
      "PrimaryEmailAddr" => {
        "Address" => form_data["email_address"]
      },
      "ShipAddr" => {
        "PostalCode" => form_data["shipping_zip_code"],
        "City" => form_data["shipping_city"],
        "Line1" => form_data["shipping_street_address"],
        "CountrySubDivisionCode" => form_data["shipping_state"],
        "Country" => form_data["shipping_country"]
      },
      "BillAddr" => {
        "PostalCode" => form_data["billing_zip_code"],
        "City" => form_data["billing_city"],
        "Line1" => form_data["billing_street_address"],
        "CountrySubDivisionCode" => form_data["billing_state"],
        "Country" => form_data["billing_country"]
      },
      "CompanyName" => form_data["business_name"],
      "CustomerTypeRef" => {
        "value": form_data["customer_type_id"]
      }
    }
    respond_to do |format|
      begin
        qb_request(lambda {
          response = qb_api.create(:customer, payload: data)
          format.html { redirect_to quickbooks_customer_path(response["Id"]), notice: "Customer was successfully created." }
          format.json { render :show, status: :created, location: quickbooks_customer_path(response["Id"]) }
        })
      rescue QboApi::BadRequest => e
        @customer = Quickbooks::Customer.new({})
        @customer_types = qb_request(lambda {
          qb_api.all(:customer_type).map do |type|
            Quickbooks::CustomerType.new(type)
          end
        })
        @error = "Duplicate Name Exists Error: The name supplied already exists."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: e.message, status: :unprocessable_entity }
      end
    end
  end

end
