require 'test_helper'
require 'quickbooks/customer_type'

class Quickbooks::CustomerTypeTest < ActiveSupport::TestCase

  API_DATA = {'Id' => '1', 'Name' => 'Fake', 'Active' => true}

  test 'is initialized with an id, name and active' do
    q_customer_type = Quickbooks::CustomerType.new(API_DATA)
    assert_equal API_DATA['Id'], q_customer_type.id
    assert_equal API_DATA['Name'], q_customer_type.name
    assert_equal API_DATA['Active'], q_customer_type.active
  end

  # #active?

  test 'true when initialized with Active true in parameter hash' do
    q_customer_type = Quickbooks::CustomerType.new({'Active' => true})
    assert q_customer_type.active?
  end

  test 'false when initialized with Active false in parameter hash' do
    q_customer_type = Quickbooks::CustomerType.new({'Active' => false})
    refute q_customer_type.active?
  end

end
