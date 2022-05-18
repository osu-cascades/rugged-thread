class QuoteRequestsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:new, :create]

  before_action :set_quote_request, only: %i[ show edit update destroy ]

  # GET /quote_requests or /quote_requests.json
  def index
    @quote_requests = QuoteRequest.all
  end

  # GET /quote_requests/1 or /quote_requests/1.json
  def show
  end

  def new
    @quote_request = QuoteRequest.new
    @item_types = ItemType.all
    @brands = Brand.kept
  end

  # GET /quote_requests/1/edit
  def edit
  end

  def create
    @quote_request = QuoteRequest.new(quote_request_params)
    respond_to do |format|
      if @quote_request.save
        format.html do
          flash.now[:notice] = "Thank you! Your quote request has been received."
          render :success
        end
        format.json { render :show, status: :created, location: @quote_request }
      else
        @item_types = ItemType.all
        @brands = Brand.kept
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

    def set_quote_request
      @quote_request = QuoteRequest.find(params[:id])
    end

    def quote_request_params
      params.require(:quote_request).permit(:first_name, :last_name, :email,
        :phone_number, :shipping, :promo_code, :description, :item_type_id, :brand_id,
        photos: [])
    end
end
