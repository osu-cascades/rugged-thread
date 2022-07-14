##
# Represents a QuickBooks Customer
#
class QuickbooksCustomer

  def initialize(customer)
    @data = customer
  end

  def id
    @data["Id"]
  end

  def name
    @data["DisplayName"]
  end

  def address(default = "No address")
    addr = @data["BillAddr"]
    if addr
      "#{addr["Line1"]}, #{addr["City"]} #{addr["CountrySubDivisionCode"]} #{addr["PostalCode"]}"
    else
      default
    end
  end

  def phone_number(default = "No phone number")
    @data.dig("PrimaryPhone", "FreeFormNumber") || default
  end

  def email_address(default = "No email address")
    @data.dig("PrimaryEmailAddr", "Address") || default
  end

end
