class ComplicationsController < ApplicationController
  before_action :set_complication, only: %i[ show edit update destroy ]

  # GET /complications or /complications.json
  def index
    @complications = Complication.all
  end

  # GET /complications/1 or /complications/1.json
  def show
  end

  # GET /complications/new
  def new
    @complication = Complication.new
  end

  # GET /complications/1/edit
  def edit
  end

  # POST /complications or /complications.json
  def create
    @complication = Complication.new(complication_params)

    respond_to do |format|
      if @complication.save
        format.html { redirect_to @complication, notice: "Complication was successfully created." }
        format.json { render :show, status: :created, location: @complication }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @complication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /complications/1 or /complications/1.json
  def update
    respond_to do |format|
      if @complication.update(complication_params)
        format.html { redirect_to @complication, notice: "Complication was successfully updated." }
        format.json { render :show, status: :ok, location: @complication }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @complication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /complications/1 or /complications/1.json
  def destroy
    @complication.destroy
    respond_to do |format|
      format.html { redirect_to complications_url, notice: "Complication was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complication
      @complication = Complication.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def complication_params
      params.require(:complication).permit(:time, :charge, :repair_id, :complication_type_id)
    end
end
