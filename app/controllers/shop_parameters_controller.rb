class ShopParametersController < ApplicationController
  before_action :set_shop_parameter, only: %i[ show edit update archive recover destroy ]

  # GET /shop_parameters or /shop_parameters.json
  def index
    if params[:show_archive] == 'true'
      @shop_parameters = ShopParameter.where('discarded_at IS NOT NULL')
    else
      @shop_parameters = ShopParameter.kept
    end
  end

  # GET /shop_parameters/1 or /shop_parameters/1.json
  def show
  end

  # GET /shop_parameters/new
  def new
    @shop_parameter = ShopParameter.new
  end

  # GET /shop_parameters/1/edit
  def edit
  end

  # POST /shop_parameters or /shop_parameters.json
  def create
    @shop_parameter = ShopParameter.new(shop_parameter_params)

    respond_to do |format|
      if @shop_parameter.save
        format.html { redirect_to @shop_parameter, notice: "Shop parameter was successfully created." }
        format.json { render :show, status: :created, location: @shop_parameter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shop_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop_parameters/1 or /shop_parameters/1.json
  def update
    respond_to do |format|
      if @shop_parameter.update(shop_parameter_params)
        format.html { redirect_to @shop_parameter, notice: "Shop parameter was successfully updated." }
        format.json { render :show, status: :ok, location: @shop_parameter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shop_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    respond_to do |format|
      if @shop_parameter.discard
        format.html { redirect_to shop_parameters_url, notice: "Shop Parameter was successfully archived." }
        format.json { head :no_content }
      else
        format.html { redirect_to shop_parameters_url, alert: 'Cannot archive this shop parameter.' }
        format.json { render json: @shop_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  def recover
    respond_to do |format|
      if @shop_parameter.undiscard
        format.html { redirect_to shop_parameters_url, notice: "Shop Parameter was successfully recovered." }
        format.json { head :no_content }
      else
        format.html { redirect_to shop_parameters_url, alert: 'Cannot recover this shop parameter.' }
        format.json { render json: @shop_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop_parameters/1 or /shop_parameters/1.json
  def destroy
    @shop_parameter.destroy
    respond_to do |format|
      format.html { redirect_to shop_parameters_url, notice: "Shop parameter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_parameter
      @shop_parameter = ShopParameter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shop_parameter_params
      params.require(:shop_parameter).permit(:name, :amount)
    end
end
