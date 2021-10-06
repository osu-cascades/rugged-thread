class InvoiceItemsController < ApplicationController
  before_action :set_invoice_item, only: %i[ show edit update destroy ]

  # GET /invoice_items or /invoice_items.json
  def index
    @invoice_items = InvoiceItem.all
  end

  # GET /invoice_items/1 or /invoice_items/1.json
  def show
  end

  # GET /invoice_items/new
  def new
    @invoice_item = InvoiceItem.new
  end

  # GET /invoice_items/1/edit
  def edit
  end

  # POST /invoice_items or /invoice_items.json
  def create
    @invoice_item = InvoiceItem.new(invoice_item_params)

    respond_to do |format|
      if @invoice_item.save
        format.html { redirect_to @invoice_item, notice: "Invoice item was successfully created." }
        format.json { render :show, status: :created, location: @invoice_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoice_items/1 or /invoice_items/1.json
  def update
    respond_to do |format|
      if @invoice_item.update(invoice_item_params)
        format.html { redirect_to @invoice_item, notice: "Invoice item was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_items/1 or /invoice_items/1.json
  def destroy
    @invoice_item.destroy
    respond_to do |format|
      format.html { redirect_to invoice_items_url, notice: "Invoice item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_item
      @invoice_item = InvoiceItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_item_params
      params.require(:invoice_item).permit(:description, :number, :invoice_number, :charge, :quote, :notes, :invoice_id, :item_type_id)
    end
end
