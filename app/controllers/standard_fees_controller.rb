class StandardFeesController < ApplicationController
  before_action :set_standard_fee, only: %i[ show edit update destroy archive recover ]

  # GET /standard_fees or /standard_fees.json
  def index
    if params[:show_archive] == 'true'
      @standard_fees = StandardFee.where('discarded_at IS NOT NULL')
    else
      @standard_fees = StandardFee.kept
    end
  end

  # GET /standard_fees/1 or /standard_fees/1.json
  def show
  end

  # GET /standard_fees/new
  def new
    @standard_fee = StandardFee.new
  end

  # GET /standard_fees/1/edit
  def edit
  end

  # POST /standard_fees or /standard_fees.json
  def create
    @standard_fee = StandardFee.new(standard_fee_params)

    respond_to do |format|
      if @standard_fee.save
        format.html { redirect_to @standard_fee, notice: "Standard Fee was successfully created." }
        format.json { render :show, status: :created, location: @standard_fee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @standard_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /standard_fees/1 or /standard_fees/1.json
  def update
    respond_to do |format|
      if @standard_fee.update(standard_fee_params)
        format.html { redirect_to @standard_fee, notice: "Standard Fee was successfully updated." }
        format.json { render :show, status: :ok, location: @standard_fee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @standard_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    respond_to do |format|
      if @standard_fee.discard
        format.html { redirect_to standard_fees_url, notice: "Standard Fee was successfully archived." }
        format.json { head :no_content }
      else
        format.html { redirect_to standard_fees_url, alert: 'Cannot archive this Standard Fee.' }
        format.json { render json: @standard_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  def recover
    respond_to do |format|
      if @standard_fee.undiscard
        format.html { redirect_to standard_fees_url, notice: "Standard Fee was successfully recovered." }
        format.json { head :no_content }
      else
        format.html { redirect_to standard_fees_url, alert: 'Cannot recover this Standard Fee.' }
        format.json { render json: @standard_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /standard_fees/1 or /standard_fees/1.json
  def destroy
    respond_to do |format|
      if @standard_fee.destroy
        format.html { redirect_to standard_fees_url, notice: "Standard fee was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to @standard_fee, alert: 'Cannot delete this standard fee.' }
        format.json { render json: @standard_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standard_fee
      @standard_fee = StandardFee.find(params[:id])
    end

    def standard_fee_params
      params.require(:standard_fee).permit(:name, :price)
    end

end
