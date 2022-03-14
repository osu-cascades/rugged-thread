require "test_helper"
require 'work_order_number'

class WorkOrderNumberTest < ActiveSupport::TestCase

  test '#number_for_month returns the number of WorkOrders created during that month' do
    assert_equal "2203-000#{work_orders.count + 1}", WorkOrderNumber.to_s
  end

end
