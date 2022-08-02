module Quickbooks

  class Customer
    extend ActiveModel::Naming

    attr_reader :errors

    def initialize(customer)
      @data = customer
      @errors = ActiveModel::Errors.new(self)
    end

    def read_attribute_for_validation(attr)
      send(attr)
    end

    def self.human_attribute_name(attr, options = {})
      attr
    end

    def self.lookup_ancestors
      [self]
    end

    def id
      @data["Id"]
    end

    def active?
      @data["Active"]
    end

    def display_name
      @data["DisplayName"]
    end

    def full_name
      "#{first_name} #{last_name}"
    end

    def first_name
      @data["GivenName"]
    end

    def last_name
      @data["FamilyName"]
    end

    def business_name
      @data["CompanyName"]
    end

    def billing_street_address(default = "")
      @data.dig("BillAddr", "Line1") || default
    end

    def billing_city(default = "")
      @data.dig("BillAddr", "City") || default
    end

    def billing_state(default = "")
      @data.dig("BillAddr", "CountrySubDivisionCode") || default
    end

    def billing_country(default = "")
      @data.dig("BillAddr", "Country") || default
    end

    def billing_zip_code(default = "")
      @data.dig("BillAddr", "PostalCode") || default
    end

    def billing_full_address(default = "")
      "#{billing_street_address}, #{billing_city} #{billing_state} #{billing_zip_code}"
    end

    def shipping_street_address(default = "")
      @data.dig("ShipAddr", "Line1") || default
    end

    def shipping_city(default = "")
      @data.dig("ShipAddr", "City") || default
    end

    def shipping_state(default = "")
      @data.dig("ShipAddr", "CountrySubDivisionCode") || default
    end

    def shipping_country(default = "")
      @data.dig("ShipAddr", "Country") || default
    end

    def shipping_zip_code(default = "")
      @data.dig("ShipAddr", "PostalCode") || default
    end

    def shipping_full_address(default = "")
      out = "#{shipping_street_address}, #{shipping_city} #{shipping_state} #{shipping_zip_code}"
      if out != ", "
        out
      else
        default
      end
    end

    def phone_number(default = "")
      @data.dig("PrimaryPhone", "FreeFormNumber") || default
    end

    def phone_number=(value)
      @data.merge!({
        "PrimaryPhone" => {
          "FreeFormNumber" => value
        }
      })
    end

    def alternative_phone_number(default = "")
      @data.dig("AlternatePhone", "FreeFormNumber") || default
    end

    def alternative_phone_number=(value)
      @data.merge!({
        "AlternatePhone" => {
          "FreeFormNumber" => value
        }
      })
    end

    def email_address(default = "")
      @data.dig("PrimaryEmailAddr", "Address") || default
    end

    def customer_type(default = "None")
      type_ref = @data.dig("CustomerTypeRef", "value")
      if type_ref.nil?
        CustomerType.new(name: default)
      else
        CustomerType.find_by(q_customer_type_id: type_ref) || CustomerType.new(name: default)
      end
    end

    def customer_type_id
      @data.dig("CustomerTypeRef", "value")
    end

    def created_at
      @data.dig("MetaData", "CreateTime")
    end

    def updated_at
      @data.dig("MetaData", "LastUpdatedTime")
    end

  end

  class QuickbooksCustomerType

    def initialize(data)
      @data = data
    end

    def id
      @data["Id"]
    end

    def name
      @data["Name"]
    end

    def active?
      @data["Active"]
    end

    def customers_with_type
      Quickbooks.request do
        # Quickbooks querying doesn't allow you query the CustomerTypeRef value, so you have to do it manually...
        Quickbooks.qbo_api.all(:customer).map do |c|
          Quickbooks::Customer.new(c)
        end.filter do |customer|
          customer.customer_type_id === id
        end
      end
    end

    ##
    # Creates a CustomerType from a customer type id.
    #
    # @param [Integer] id The id of the customer type
    # @return [Quickbooks::CustomerType]
    #
    def self.from_id(id)
      Quickbooks.request do
        data = Quickbooks.qbo_api.get(:customer_type, id)
        QuickbooksCustomerType.new data
      end
    end

    def to_s
      name
    end

  end

  class Invoice

    attr_reader :items, :work_orders

    def initialize
      @now = DateTime.now
      @data = {
        "Line" => []
      }
      @items = []
      @work_orders = []
    end

    def set_customer(customer_id)
      @data["CustomerRef"] = {
        "value" => customer_id
      }
    end

    def assign_doc_number
      invoice_number = InvoiceNumbers.first || InvoiceNumbers.create(year: @now.year, month: @now.month, number: 0)
      invoice_number.number += 1
      # Reset number to 1 on a new month
      if invoice_number.year != @now.year || invoice_number.month != @now.month
        invoice_number.number = 1
        invoice_number.year = @now.year
        invoice_number.month = @now.month
      end
      invoice_number.save

      @data["DocNumber"] = "#{@now.year % 100}#{@now.month.to_s.rjust(2, "0")}#{invoice_number.number.to_s.rjust(4, "0")}"
    end

    ##
    # Adds a work order and all of it's items, generating all necessary lines
    #
    # @param [WorkOrder] work_order
    #
    def add_work_order(work_order)
      @work_orders.push work_order
      work_order.items.each do |item|
        add_item(item)
      end
    end

    ##
    # Adds an item to the invoice, generating all necessary lines
    #
    # @param [Item] item The item to add to the invoice
    #
    def add_item(item)
      @items.push item
      item_description = "#{item.brand.name} #{item.item_type.name}"
      item_labor_amount = 0
      inventory_items = []
      special_order_items = []
      item.repairs.each do |repair|
        item_description += "\n- #{repair.name.match(/^(.*?)?\s*?[^\w\s]|$/)[1]}"
        item_labor_amount += repair.price_of_labor.to_f
        repair.inventory_items.each do |inventory|
          inventory_items.push inventory
        end
        repair.special_order_items.each do |special_item|
          special_order_items.push special_item
        end
      end
      add_line(item_name: "Repair", amount: item_labor_amount, description: item_description)
      inventory_items.each do |inv_item|
        add_line(item_name: "Inventory Item", amount: inv_item.price.to_f, description: inv_item.name)
      end
      special_order_items.each do |soi|
        add_line(item_name: "Special Order Item", amount: soi.total_price.to_f, description: soi.name)
      end
      item.fees.each do |fee|
        add_line(item_name: "Fee", amount: fee.price.to_f, description: fee.name)
      end
      subtotal_before_discount = item.price_of_repairs_and_fees.to_f
      item.discounts.each do |discount|
        discount_amount = 0
        if discount.price.present?
          discount_amount = discount.price.to_f
        else
          # percentage discount
          converted_percent = discount.percentage_amount / 100.to_f
          discount_amount = subtotal_before_discount * converted_percent
        end
        add_line(item_name: "Discount", amount: -discount_amount, description: discount.name)
      end
    end

    def add_line(item: nil, item_name: nil, amount: 0, description: nil, service_date: nil)
      item_ref = {"name" => item_name}
      if item.present?
        item_ref["value"] = item
      else
        # only name present, must fetch actual id
        begin
          r = Quickbooks.qbo_api.get(:item, ["Name", item_name])
          item_ref["value"] = r["Id"]
        rescue
          item_ref["value"] = 1
        end
      end
      line = {
        "DetailType" => "SalesItemLineDetail",
        "Description" => description,
        "Amount" => amount,
        "SalesItemLineDetail" => {
          "ServiceDate" => service_date || "#{@now.year}-#{@now.month.to_s.rjust(2, "0")}-#{@now.day.to_s.rjust(2, "0")}",
          "ItemRef" => item_ref
        }
      }
      @data["Line"].push line
    end

    def payload
      @data
    end

  end

  class << self

    @@cache = {}

    ##
    # Checks whether Quickbooks integration has been set up on the server.
    #
    def qbo_authenticated?
      !QuickbooksSession.first.nil?
    end

    ##
    # Creates a QboApi instance which can be used to query quickbooks.
    #
    # @return [QboApi]
    #
    def qbo_api
      qbo_data = QuickbooksSession.first
      if !Rails.env.development?
        QboApi.production = true
      end
      QboApi.new(access_token: qbo_data["access_token"], realm_id: qbo_data["realm_id"])
    end

    ##
    # Wrapper used when using the quickbooks api.
    # Checks for problems with quickbooks authentication and raises errors.
    #
    # @param [Hash] options unused
    #
    # @raise [Quickbooks::DataUnitializedError] if the session data has not been created yet
    # @raise [Quickbooks::UnauthorizedError] if the session data is invalid or outdated
    #
    def request(options = {})
      if options[:clear_cache]
        @@cache = {}
      end
      if !qbo_authenticated?
        raise Quickbooks::DataUninitializedError, "QuickBooks session data is missing"
      else
        begin
          yield
        rescue QboApi::Unauthorized
          raise Quickbooks::UnauthorizedError, "QuickBooks session is outdated or invalid"
        end
      end
    end

    ##
    # Creates an OAuth client for authenticating QuickBooks accounts.
    #
    # @param [String] redirect The redirect url to be sent back to after authentication
    # @return [Rack::OAuth2::Client]
    #
    def oauth_client(redirect = nil)
      id = Rails.application.credentials.qbo.client_id!
      secret = Rails.application.credentials.qbo.client_secret!
      Rack::OAuth2::Client.new(
        identifier: id,
        secret: secret,
        redirect_uri: redirect,
        authorization_endpoint: "https://appcenter.intuit.com/connect/oauth2",
        token_endpoint: "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer"
      )
    end

    def oauth_authorization_url(client)
      client.authorization_uri(
        scope: "com.intuit.quickbooks.accounting",
        response_type: "code",
        state: "Stitch"
      )
    end

    ##
    # Counts the total number of an item
    #
    # @param [String] type The table to query
    # @return [Integer]
    #
    def count_all(type)
      qbo_api.query("SELECT COUNT(*) FROM #{type}")["QueryResponse"]["totalCount"]
    end

    def cache
      return @@cache
    end

  end

  class UnauthorizedError < StandardError
  end

  class DataUninitializedError < StandardError
  end

end
