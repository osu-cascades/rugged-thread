require "test_helper"

class WorkOrderTest < ActiveSupport::TestCase

  test 'attributes'do
    assert_respond_to(WorkOrder.new, :in_date)
    assert_respond_to(WorkOrder.new, :due_date)
    assert_respond_to(WorkOrder.new, :shipping)
  end

  test 'associations' do
    assert_respond_to(WorkOrder.new, :creator)
    assert_respond_to(WorkOrder.new, :customer)
    assert_respond_to(WorkOrder.new, :items)
  end

  test "cannot be deleted if it has associated items" do
    work_order = work_orders(:shipping)
    assert_not_empty work_order.items
    work_order.destroy
    refute work_order.destroyed?
  end

  test '#to_s string representation' do
    work_order = work_orders(:shipping)
    expected = "Work Order #{work_order.id}"
    assert_equal expected, work_order.to_s
  end

  test 'is invalid without a date in' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.in_date = nil
    refute work_order.valid?
    work_order.in_date = ''
    refute work_order.valid?
  end

  test 'is invalid without a due date' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.due_date = nil
    refute work_order.valid?
    work_order.due_date = ''
    refute work_order.valid?
  end

  test 'is invalid when due date is before date in' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.due_date = work_order.in_date
    refute work_order.valid?
  end

  test 'is invalid without a creator' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.creator = nil
    refute work_order.valid?
  end

  test 'is invalid without a customer' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.customer = nil
    refute work_order.valid?
  end

  # Default initialization of in date and due date

  test 'in date is initialized to current date by default' do
    work_order = WorkOrder.new
    assert_equal Date.current, work_order.in_date
  end

  test 'in date is not automatically initialized if it already exists' do
    specific_in_date = Date.current - 1.day
    work_order = WorkOrder.new(in_date: specific_in_date)
    assert_equal specific_in_date, work_order.in_date
  end

  test 'due date is initialized to customer type turn-around days from the in date by default' do
    work_order = customers.first.work_orders.build
    turn_around = customers.first.customer_type.turn_around
    assert_equal work_order.in_date + turn_around.days, work_order.due_date
  end

  test 'due date is initialized to the in date when no customer exists' do
    work_order = WorkOrder.new
    assert_equal work_order.in_date, work_order.due_date
  end

  test 'due date is not automatically initialized if it already exists' do
    specific_due_date = Date.current + 1.day
    work_order = customers.first.work_orders.build(due_date: specific_due_date)
    assert_equal specific_due_date, work_order.due_date
  end

  test "in date does not automaticallay initialize when work order is already persisted" do
    work_order = work_orders(:shipping)
    original_in_date = work_order.in_date
    work_order.in_date = original_in_date - 1.day
    work_order.save!
    work_order = work_orders(:shipping)
    refute_equal original_in_date, work_order.in_date
  end

  test "due date does not automaticallay initialize when work order is already persisted" do
    work_order = work_orders(:shipping)
    original_due_date = work_order.due_date
    work_order.due_date = original_due_date + 1.day
    work_order.save!
    work_order = work_orders(:shipping)
    refute_equal original_due_date, work_order.due_date
  end

  test '#price_estimate is the sum of all item estimates' do
    work_order = work_orders(:itemless)
    assert_equal(0, work_order.price_estimate)
    item = Item.new
    def item.price_estimate
      99
    end
    work_order.items << item
    assert_equal(99, work_order.price_estimate)
  end

end
