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
        Quickbooks.request(lambda {
          data = Quickbooks.qbo_api.get(:customertype, type_ref)
          @customer_type = data.dig("CustomerType", "Name")
        })
        @customer_type
      else
        default
      end
    end

  end

  class << self

    def qbo_authenticated?
      !QuickbooksSession.first.nil?
    end

    def qbo_api
      qbo_data = QuickbooksSession.first
      if !Rails.env.development?
        QboApi.production = true
      end
      QboApi.new(access_token: qbo_data["access_token"], realm_id: qbo_data["realm_id"])
    end

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
