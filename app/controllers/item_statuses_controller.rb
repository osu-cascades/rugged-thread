class ItemStatusesController < ApplicationController
  before_action :set_item_status, only: %i[ edit update destroy ]

  # GET /item_statuses or /item_statuses.json
  def index
    @item_statuses = ItemStatus.all
  end

  def show
    @item_status = ItemStatus.find(params[:id])
    @items = @item_status.items
  end

  # GET /item_statuses/new
  def new
    @item_status = ItemStatus.new
  end

  # GET /item_statuses/1/edit
  def edit
  end

  # POST /item_statuses or /item_statuses.json
  def create
    @item_status = ItemStatus.new(item_status_params)

    respond_to do |format|
      if @item_status.save
        format.html { redirect_to @item_status, notice: "Item status was successfully created." }
        format.json { render :show, status: :created, location: @item_status }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_statuses/1 or /item_statuses/1.json
  def update
    respond_to do |format|
      if @item_status.update(item_status_params)
        format.html { redirect_to @item_status, notice: "Item status was successfully updated." }
        format.json { render :show, status: :ok, location: @item_status }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item_status.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_default
    @item_status = ItemStatus.find(params[:id])
    @item_status.make_default!
    respond_to do |format|
      format.html { redirect_to item_statuses_url, notice: "#{@item_status} is now the default." }
      format.json { render :show, status: :ok, location: @item_status }
    end
  end

  # DELETE /item_statuses/1 or /item_statuses/1.json
  def destroy
    respond_to do |format|
      if @item_status.destroy
        format.html { redirect_to item_statuses_url, notice: "Item status was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to item_statuses_url, alert: 'Cannot delete this item status.' }
        format.json { render json: @item_status.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_status
      @item_status = ItemStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_status_params
      params.require(:item_status).permit(:name)
    end
end
