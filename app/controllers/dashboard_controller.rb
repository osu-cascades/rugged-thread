class DashboardController < ApplicationController

  def show
    @open_work_orders = WorkOrder.open
    @number_of_open_work_orders = @open_work_orders.size
    @total_price_of_open_work_orders = @open_work_orders.reduce(Money.new(0)) { |sum, wo| sum + wo.price }
  end

end
