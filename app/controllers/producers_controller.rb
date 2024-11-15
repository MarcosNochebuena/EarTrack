class ProducersController < ApplicationController
  before_action :set_producer, only: %i[ edit update ]

  # GET /producers or /producers.json
  def index
    @producer = current_user.producer || Producer.new
    render (@producer.persisted? ? :edit : :new)
  end

  # GET /producers/1 or /producers/1.json
  # def show
  # end

  # GET /producers/new
  # def new
  #   @producer = Producer.new
  # end

  # GET /producers/1/edit
  # def edit
  # end

  # POST /producers or /producers.json
  def create
    @producer = Producer.new(producer_params)

    respond_to do |format|
      if @producer.save
        current_user.update(producer: @producer)
        format.html { redirect_to producers_path, notice: "Producer was successfully created." }
        format.json { render :show, status: :created, location: @producer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @producer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /producers/1 or /producers/1.json
  def update
    respond_to do |format|
      if @producer.update(producer_params)
        format.html { redirect_to producers_path, notice: "Producer was successfully updated." }
        format.json { render :show, status: :ok, location: @producer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @producer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /producers/1 or /producers/1.json
  # def destroy
  #   @producer.destroy

  #   respond_to do |format|
  #     format.html { redirect_to producers_url, notice: "Producer was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producer
      @producer = Producer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def producer_params
      params.require(:producer).permit(:upp_key, :producer_full_name, :produced_adress)
    end
end
