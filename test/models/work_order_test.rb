require "test_helper"

class WorkOrderTest < ActiveSupport::TestCase

  test "belongs to a customer" do
    assert_respond_to(WorkOrder.new, :customer)
  end

  test "has many items" do
    assert_respond_to(WorkOrder.new, :items)
  end

  test "cannot be deleted if it has associated items" do
    work_order = work_orders(:shipping)
    assert_not_empty work_order.items
    work_order.destroy
    refute work_order.destroyed?
  end

end
