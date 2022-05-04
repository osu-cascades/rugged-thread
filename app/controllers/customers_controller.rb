class CustomersController < ApplicationController
  include Pagy::Backend

  before_action :set_customer, only: %i[ update destroy archive recover ]

  def index
    if params[:show_archive] == 'true'
      @pagy, @customers = pagy(Customer.where('discarded_at IS NOT NULL AND last_name ILIKE ?', "%#{params[:query]}%").order(last_name: :asc))
    else
      @pagy, @customers = pagy(Customer.kept.where('last_name ILIKE ?', "%#{params[:query]}%").order(last_name: :asc))
    end
    rescue Pagy::OverflowError
      redirect_to customers_url
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

  def archive
    respond_to do |format|
      if @customer.discard
        format.html { redirect_to customers_url, notice: "Customer was successfully archived." }
        format.json { head :no_content }
      else
        format.html { redirect_to customers_url, alert: 'Cannot archive this customer.' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def recover
    respond_to do |format|
      if @customer.undiscard
        format.html { redirect_to customers_url, notice: "Customer was successfully recovered." }
        format.json { head :no_content }
      else
        format.html { redirect_to customers_url, alert: 'Cannot recover this customer.' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @customer.destroy
        format.html { redirect_to customers_url, notice: "Customer was successfully deleted." }
        format.json { head :no_content }
      else
        format.html { redirect_to customers_url, alert: 'This customer cannot be deleted because there are work orders associated with them in the system.' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:customer_type_id, :first_name, :last_name,
       :business_name, :phone_number, :alternative_phone_number, :email_address,
       :shipping_street_address, :shipping_city, :shipping_state, :shipping_zip_code,
       :billing_street_address, :billing_city, :billing_state, :billing_zip_code, :check_address)
    end

end
