class EarringsController < ApplicationController
  before_action :set_earring, only: %i[ show edit update destroy ]

  # GET /earrings or /earrings.json
  def index
    @earrings = Earring.all
    @earring = Earring.new
  end

  # GET /earrings/1 or /earrings/1.json
  def show
  end

  # GET /earrings/new
  def new
    @earring = Earring.new
    @keys = Key.all
  end

  # GET /earrings/1/edit
  def edit
  end

  # POST /earrings or /earrings.json
  def create
    @earring = Earring.new(earring_params)

    respond_to do |format|
      if @earring.save
        format.html { redirect_to earring_url(@earring), notice: "Earring was successfully created." }
        format.json { render :show, status: :created, location: @earring }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @earring.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /earrings/1 or /earrings/1.json
  def update
    respond_to do |format|
      if @earring.update(earring_params)
        format.html { redirect_to earring_url(@earring), notice: "Earring was successfully updated." }
        format.json { render :show, status: :ok, location: @earring }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @earring.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /earrings/1 or /earrings/1.json
  def destroy
    @earring.destroy

    respond_to do |format|
      format.html { redirect_to earrings_url, notice: "Earring was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_earring
      @earring = Earring.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def earring_params
      params.require(:earring).permit(:key_id, :earring, :status, :age, :gender, :photo)
    end
end
