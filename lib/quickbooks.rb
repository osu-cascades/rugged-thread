module Quickbooks

  class Customer

    def initialize(customer)
      @data = customer
    end

    def id
      @data["Id"]
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

    def alternative_phone_number(default = "")
      @data.dig("AlternatePhone", "FreeFormNumber") || default
    end

    def email_address(default = "")
      @data.dig("PrimaryEmailAddr", "Address") || default
    end

    def customer_type(default = "None")
      if !@customer_type.nil?
        return @customer_type
      end
      type_ref = @data.dig("CustomerTypeRef", "value") || nil
      if !type_ref.nil? then
        @customer_type = CustomerType.from_id(type_ref)
      else
        default
      end
    end

  end

  class CustomerType

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

    ##
    # Creates a CustomerType from a customer type id.
    #
    # @param [Integer] id The id of the customer type
    # @return [Quickbooks::CustomerType]
    #
    def self.from_id(id)
      Quickbooks.request(lambda {
        data = Quickbooks.qbo_api.get(:customer_type, id)
        CustomerType.new data
      })
    end

    def to_s
      name
    end

  end

  class << self

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
    # @param [Method] func
    # @param [Hash] options unused
    #
    # @raise [Quickbooks::DataUnitializedError] if the session data has not been created yet
    # @raise [Quickbooks::UnauthorizedError] if the session data is invalid or outdated
    #
    def request(func, options = {})
      if !qbo_authenticated?
        raise Quickbooks::DataUninitializedError, "QuickBooks session data is missing"
      else
        begin
          return func.call
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
      id = ENV["QB_CLIENT_ID"]
      secret = ENV["QB_CLIENT_SECRET"]
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

  end

  class UnauthorizedError < StandardError
  end

  class DataUninitializedError < StandardError
  end

end
