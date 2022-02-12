ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)
  fixtures :all

  def defines_before_filter?(controller_class, method_symbol)
    controller_class._process_action_callbacks.map {|c| c.filter if c.kind == :before}.compact.include? method_symbol
  end

end
