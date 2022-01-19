class WorkOrdersController < ApplicationController

  
    # GET /work_orders/1 or /work_orders/1.json
    # def show
    # end
  
    # GET /work_orders/new
    def new
      @work_order = work_order.new
    end
  
    # GET /work_orders/1/edit
    def edit
    end

end