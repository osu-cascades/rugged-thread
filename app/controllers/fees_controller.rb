class FeesController < ApplicationController
  before_action :set_fee, only: %i[ show edit update destroy ]

  # GET /fees or /fees.json
  def index
    @fees = Fee.all
  end

  # GET /fees/1 or /fees/1.json
  def show
  end

  # GET /fees/new
  def new
    @fee = Fee.new
  end

  # GET /fees/1/edit
  def edit
  end

  # POST /fees or /fees.json
  def create
    @fee = Fee.new(fee_params)

    respond_to do |format|
      if @fee.save
        format.html { redirect_to @fee, notice: "Fee was successfully created." }
        format.json { render :show, status: :created, location: @fee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fees/1 or /fees/1.json
  def update
    respond_to do |format|
      if @fee.update(fee_params)
        format.html { redirect_to @fee, notice: "Fee was successfully updated." }
        format.json { render :show, status: :ok, location: @fee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1 or /fees/1.json
  def destroy
    @fee.destroy
    respond_to do |format|
      format.html { redirect_to fees_url, notice: "Fee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee
      @fee = Fee.find(params[:id])
    end

    def fee_params
      params.require(:fee).permit(:name, :price)
    end

end
