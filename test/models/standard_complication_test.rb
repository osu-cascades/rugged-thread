require "test_helper"

class StandardComplicationTest < ActiveSupport::TestCase

  test "attribtues" do
    assert_respond_to(StandardComplication.new, :name)
    assert_respond_to(StandardComplication.new, :charge)
  end

  test "associations" do
    assert_respond_to(StandardComplication.new, :standard_repair)
    assert_respond_to(StandardComplication.new, :complications)
  end

  test 'cannot be deleted if it has associated complications' do
    standard_complication = standard_complications(:one)
    assert_not_empty standard_complication.complications
    standard_complication.destroy
    refute standard_complication.destroyed?
  end

  test 'can be deleted if it has no associated complications' do
    standard_complication = standard_complications(:complicationless)
    assert_empty standard_complication.complications
    standard_complication.destroy
    assert standard_complication.destroyed?
  end

  test 'is not valid without a name' do
    standard_complication = standard_complications(:one)
    assert standard_complication.valid?
    standard_complication.name = ''
    refute standard_complication.valid?
  end

  test 'charge must be a positive integer' do
    standard_complication = standard_complications(:one)
    assert standard_complication.valid?
    standard_complication.charge = -1
    refute standard_complication.valid?
  end

  test "#to_s string representation is name" do
    name = 'FAKE'
    standard_complication = StandardComplication.new(name: name)
    assert_equal name, standard_complication.to_s
  end

end
