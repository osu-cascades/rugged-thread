class ItemTypesController < ApplicationController
  before_action :set_item_type, only: %i[ edit update destroy ]

  # GET /item_types or /item_types.json
  def index
    @item_types = ItemType.all
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

  # DELETE /item_types/1 or /item_types/1.json
  def destroy
    @item_type.destroy
    respond_to do |format|
      format.html { redirect_to item_types_url, notice: "Item type was successfully destroyed." }
      format.json { head :no_content }
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
