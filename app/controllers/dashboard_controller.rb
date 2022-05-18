class DashboardController < ApplicationController

  def show
    non_invoiced_items = Item.kept.not_invoiced.with_associated_priced_models
    @number_of_non_invoiced_items = non_invoiced_items.size
    @total_price_of_non_invoiced_items = non_invoiced_items.reduce(Money.new(0)) { |sum, i| sum + i.price }
  end

end
