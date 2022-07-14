module Quickbooks

  class Customer

    attr_reader :customer_type

    def initialize(customer, controller = nil)

      @data = customer
      @controller = controller

      type_ref = @data.dig("CustomerTypeRef", "value") || nil
      if !type_ref.nil? && !@controller.nil? then
        @controller.qb_request(lambda {
          data = @controller.qb_api.get(:customertype, type_ref)
          @customer_type = data.dig("CustomerType", "Name")
        })
      end

    end

    def id
      @data["Id"]
    end

    def name
      @data["DisplayName"]
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
      @data.dig("BillAddr", "City") || default
    end

    def billing_country(default = "")
      @data.dig("BillAddr", "CountrySubDivisionCode") || default
    end

    def billing_zip_code(default = "")
      @data.dig("BillAddr", "PostalCode") || default
    end

    def billing_full_address(default = "")
      "#{billing_street_address}, #{billing_city} #{billing_country} #{billing_zip_code}"
    end

    def shipping_street_address(default = "")
      @data.dig("ShipAddr", "Line1") || default
    end

    def shipping_city(default = "")
      @data.dig("ShipAddr", "City") || default
    end

    def shipping_state(default = "")
      @data.dig("ShipAddr", "City") || default
    end

    def shipping_country(default = "")
      @data.dig("ShipAddr", "CountrySubDivisionCode") || default
    end

    def shipping_zip_code(default = "")
      @data.dig("ShipAddr", "PostalCode") || default
    end

    def shipping_full_address(default = "")
      out = "#{shipping_street_address}, #{shipping_city} #{shipping_country} #{shipping_zip_code}"
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

  end

end
