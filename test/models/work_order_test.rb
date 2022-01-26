require "test_helper"

class WorkOrderTest < ActiveSupport::TestCase

  test "has many items" do
    assert_respond_to(WorkOrder.new, :items)
  end

end
