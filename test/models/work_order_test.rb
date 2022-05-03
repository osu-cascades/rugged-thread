require "test_helper"

class WorkOrderTest < ActiveSupport::TestCase

  test 'attributes'do
    assert_respond_to(WorkOrder.new, :in_date)
    assert_respond_to(WorkOrder.new, :due_date)
    assert_respond_to(WorkOrder.new, :shipping)
    assert_respond_to(WorkOrder.new, :number)
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
    expected = "Work Order #{work_order.number}"
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

  test 'is invalid without a formatted number' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.number = nil
    refute work_order.valid?
    work_order.number = 'FAKE'
    refute work_order.valid?
  end

  test 'is invalid when number is not unique' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.number = work_orders(:not_shipping).number
    refute work_order.valid?
  end

  # Scopes

  test 'open' do
    open_work_orders = WorkOrder.open
    refute open_work_orders.include? work_orders(:invoiced)
    refute open_work_orders.include? work_orders(:archived)
    assert open_work_orders.include? work_orders(:open)
  end

  test 'invoiced' do
    open_work_orders = WorkOrder.invoiced
    assert open_work_orders.include? work_orders(:invoiced)
    refute open_work_orders.include? work_orders(:archived)
    refute open_work_orders.include? work_orders(:open)
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

  test 'number is assigned after saving' do
    work_order = WorkOrder.new(creator: users(:staff), customer: customers(:one))
    work_order.save!
    refute work_order.number.blank?
  end

  test '#price is the sum of all item prices' do
    work_order = work_orders(:itemless)
    assert_equal(Money.new(0), work_order.price)
    item = Item.new
    def item.price
      Money.from_cents(9900)
    end
    work_order.items << item
    assert_equal(Money.from_cents(9900), work_order.price)
  end

  test '#overdue' do

  end

  test '#due_soon' do

  end

end
