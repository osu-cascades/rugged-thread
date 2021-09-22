class QuoteRequestsController < ApplicationController
  before_action :set_quote_request, only: %i[ show edit update destroy ]

  # GET /quote_requests or /quote_requests.json
  def index
    @quote_requests = QuoteRequest.all
  end

  # GET /quote_requests/1 or /quote_requests/1.json
  def show
  end

  # GET /quote_requests/new
  def new
    @quote_request = QuoteRequest.new
  end

  # GET /quote_requests/1/edit
  def edit
  end

  # POST /quote_requests or /quote_requests.json
  def create
    @quote_request = QuoteRequest.new(quote_request_params)

    respond_to do |format|
      if @quote_request.save
        format.html { redirect_to @quote_request, notice: "Quote request was successfully created." }
        format.json { render :show, status: :created, location: @quote_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quote_requests/1 or /quote_requests/1.json
  def update
    respond_to do |format|
      if @quote_request.update(quote_request_params)
        format.html { redirect_to @quote_request, notice: "Quote request was successfully updated." }
        format.json { render :show, status: :ok, location: @quote_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quote_requests/1 or /quote_requests/1.json
  def destroy
    @quote_request.destroy
    respond_to do |format|
      format.html { redirect_to quote_requests_url, notice: "Quote request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote_request
      @quote_request = QuoteRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_request_params
      params.require(:quote_request).permit(:first_name, :last_name, :email, :phone_number, :item_type, :brand, :will_mail_item, :promo_code, :description, images: [])
    end
end
