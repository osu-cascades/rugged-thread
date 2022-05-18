class CustomerTypesController < ApplicationController
  include Pagy::Backend

  before_action :set_customer_type, only: %i[ edit update destroy archive recover]

  def index
    if params[:show_archive] == 'true'
      @pagy, @customer_types = pagy(CustomerType.where('discarded_at IS NOT NULL'))
    else
      @pagy, @customer_types = pagy(CustomerType.kept)
    end
  rescue Pagy::OverflowError
    redirect_to customer_types_url
  end

  def show
    @customer_type = CustomerType.find(params[:id])
    @customers = @customer_type.customers.kept
  end

  # GET /customer_types/new
  def new
    @customer_type = CustomerType.new
  end

  # GET /customer_types/1/edit
  def edit
  end

  # POST /customer_types or /customer_types.json
  def create
    @customer_type = CustomerType.new(customer_type_params)

    respond_to do |format|
      if @customer_type.save
        format.html { redirect_to @customer_type, notice: "Customer type was successfully created." }
        format.json { render :show, status: :created, location: @customer_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_types/1 or /customer_types/1.json
  def update
    respond_to do |format|
      if @customer_type.update(customer_type_params)
        format.html { redirect_to @customer_type, notice: "Customer type was successfully updated." }
        format.json { render :show, status: :ok, location: @customer_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @customer_type.destroy
        format.html { redirect_to customer_types_url, notice: "Customer type was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to customer_types_url, alert: 'This customer type cannot be deleted, there are customers associated with it.' }
        format.json { render json: @customer_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    respond_to do |format|
      if @customer_type.discard
        format.html { redirect_to customer_types_url, notice: "Customer type was successfully archived." }
        format.json { head :no_content }
      else
        format.html { redirect_to customer_types_url, alert: 'Cannot archive this customer type.' }
        format.json { render json: @customer_type.errors, status: :unprocessable_entity }
      end
    end
  end


  def recover
    respond_to do |format|
      if @customer_type.undiscard
        format.html { redirect_to customer_types_url, notice: "Customer type was successfully recoverd." }
        format.json { head :no_content }
      else
        format.html { redirect_to customer_types_url, alert: 'Cannot recover this customer type.' }
        format.json { render json: @customer_type.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_customer_type
      @customer_type = CustomerType.find(params[:id])
    end

    def customer_type_params
      params.require(:customer_type).permit(:name, :turn_around)
    end

end
