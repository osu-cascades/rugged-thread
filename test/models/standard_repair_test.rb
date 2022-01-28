require "test_helper"

class StandardRepairTest < ActiveSupport::TestCase

  test "#to_s string representation is name" do
    name = 'FAKE'
    standard_repair = StandardRepair.new(name: name)
    assert_equal name, standard_repair.to_s
  end

end
