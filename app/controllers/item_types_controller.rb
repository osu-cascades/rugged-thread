class ItemTypesController < ApplicationController
  include Pagy::Backend

  before_action :set_item_type, only: %i[ edit update destroy archive recover]

  # GET /item_types or /item_types.json
  def index
      if params[:show_archive] == 'true'
      @pagy, @item_types = pagy(ItemType.where('discarded_at IS NOT NULL'))
    else
      @pagy, @item_types = pagy(ItemType.kept)
    end
  rescue Pagy::OverflowError
    redirect_to item_types_url
  end

  def show
    @item_type = ItemType.find(params[:id])
    @items = @item_type.items
  end

  # GET /item_types/new
  def new
    @item_type = ItemType.new
  end

  # GET /item_types/1/edit
  def edit
  end

  # POST /item_types or /item_types.json
  def create
    @item_type = ItemType.new(item_type_params)

    respond_to do |format|
      if @item_type.save
        format.html { redirect_to @item_type, notice: "Item type was successfully created." }
        format.json { render :show, status: :created, location: @item_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_types/1 or /item_types/1.json
  def update
    respond_to do |format|
      if @item_type.update(item_type_params)
        format.html { redirect_to @item_type, notice: "Item type was successfully updated." }
        format.json { render :show, status: :ok, location: @item_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @item_type.destroy
        format.html { redirect_to item_types_url, notice: "Item type was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to item_types_url, alert: 'This item type cannot be deleted, it has items associated with it.' }
        format.json { render json: @item_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    respond_to do |format|
      if @item_type.discard
        format.html { redirect_to item_types_url, notice: "Item type was successfully archived." }
        format.json { head :no_content }
      else
        format.html { redirect_to item_types_url, alert: 'Cannot archive this item type.' }
        format.json { render json: @item_type.errors, status: :unprocessable_entity }
      end
    end
  end


  def recover
    respond_to do |format|
      if @item_type.undiscard
        format.html { redirect_to item_types_url, notice: "Item type was successfully recoverd." }
        format.json { head :no_content }
      else
        format.html { redirect_to item_typees_url, alert: 'Cannot recover this item type.' }
        format.json { render json: @item_type.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_type
      @item_type = ItemType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_type_params
      params.require(:item_type).permit(:name)
    end
end
