class BrandsController < ApplicationController
  include Pagy::Backend

  before_action :set_brand, only: %i[ edit update destroy archive recover ]

  def index
    if params[:show_archive] == 'true'
      @pagy, @brands = pagy(Brand.discarded)
    else
      @pagy, @brands = pagy(Brand.kept)
    end
  rescue Pagy::OverflowError
    redirect_to brands_url
  end

  def show
    @brand = Brand.find(params[:id])
    @items = @brand.items
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands or /brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: "Brand was successfully created." }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1 or /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: "Brand was successfully updated." }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1 or /brands/1.json
  def destroy
    respond_to do |format|
      if @brand.destroy
        format.html { redirect_to brands_url, notice: "Brand was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to brands_url, alert: 'This brand cannot be deleted, there are items associated with it.' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end


  def archive
    respond_to do |format|
      if @brand.discard
        format.html { redirect_to brands_url, notice: "Brand was successfully archived." }
        format.json { head :no_content }
      else
        format.html { redirect_to brands_url, alert: 'Cannot archive this brand.' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end


  def recover
    respond_to do |format|
      if @brand.undiscard
        format.html { redirect_to brands_url, notice: "Brand was successfully recoverd." }
        format.json { head :no_content }
      else
        format.html { redirect_to brands_url, alert: 'Cannot recover this brand.' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:name)
    end
end
