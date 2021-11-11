require "test_helper"

class TechnicianTest < ActiveSupport::TestCase
  test "Technician status is active" do
    assert(technicians(:one).status)
  end
end
