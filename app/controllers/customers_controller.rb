class CustomersController < ApplicationController

  before_action :set_customer, only: %i[ update destroy ]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @work_orders = @customer.work_orders
  end

  def new
    @customer = Customer.new
    @customer_types = CustomerType.all
  end

  def edit
    @customer = Customer.find(params[:id])
    @customer_types = CustomerType.all
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: "Customer was successfully created." }
        format.json { render :show, status: :created, location: @customer }
      else
        @customer_types = CustomerType.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        @customer_types = CustomerType.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @customer.destroy
        format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to customers_url, alert: 'Cannot delete this customer.' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:customer_type_id, :first_name, :last_name, :business_name, :phone_number, :email_address, :street_address, :city, :state, :zip_code)
    end

end
