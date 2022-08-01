# This is an example / experiment for organizing our API integrations, and a
# precedent for testing.
# It is a 'copy' of the Quickbooks::QuickbooksCustomerType in lib/quickbooks.rb.

module Quickbooks

  class CustomerType

    attr_reader :id, :name, :active

    def initialize(data)
      @id = data["Id"]
      @name = data["Name"]
      @active = data["Active"]
    end

    def active?
      active
    end

    def to_s
      name
    end

  end

end
