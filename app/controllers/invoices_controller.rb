class InvoicesController < ApplicationController

  def show
    @work_order = WorkOrder.find(params[:id])
  end

  def submit
    @work_order = WorkOrder.find(params[:id])
  end

end
