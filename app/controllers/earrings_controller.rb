class EarringsController < ApplicationController
  before_action :set_earring, only: %i[ show edit update destroy ]

  # GET /earrings or /earrings.json
  def index
    # @q = Earring.includes(:key).ransack(params[:q])
    # @pagy, @earrings = pagy(@q.result(distinct: true))

    search_params = params.permit(:format, :page, q: [:earring_cont, :key_num_key_cont])
    @q = Earring.includes(:key).ransack(params[:q])
    earrings = @q.result.where(keys: {producer: current_user.producer}).order(created_at: :desc)
    @live_earrings_count = earrings.where(status: :live).count
    @pagy, @earrings = pagy_countless(earrings)
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
    begin
      # Intentar eliminar el arete
      if @earring.destroy
        respond_to do |format|
          format.html { redirect_to earrings_path, notice: "El arete fue eliminado correctamente." }
          format.turbo_stream do
            flash_turbo_stream_with_notice("El arete fue eliminado correctamente.", [turbo_stream.remove(@earring)])
          end
          format.json { head :no_content }
        end
      else
        # Si destroy devuelve false (por ejemplo, debido a callbacks)
        error_message = @earring.errors.full_messages.join(", ")
        error_message = "No se pudo eliminar el arete. Ocurrió un error inesperado." if error_message.blank?

        respond_to do |format|
          format.html { redirect_to earrings_path, alert: error_message }
          format.turbo_stream do
            flash_turbo_stream_with_alert(error_message)
          end
          format.json { render json: { error: error_message }, status: :unprocessable_entity }
        end
      end
    rescue ActiveRecord::RecordNotFound
      # Si el arete ya fue eliminado o no existe
      respond_to do |format|
        format.html { redirect_to earrings_path, alert: "El arete ya fue eliminado o no existe." }
        format.turbo_stream do
          flash_turbo_stream_with_alert("El arete ya fue eliminado o no existe.")
        end
        format.json { head :not_found }
      end
    rescue StandardError => e
      # Para cualquier otro error inesperado
      respond_to do |format|
        format.html { redirect_to earrings_path, alert: "Error al eliminar el arete: #{e.message}" }
        format.turbo_stream do
          flash_turbo_stream_with_alert("Error al eliminar el arete: #{e.message}")
        end
        format.json { render json: { error: e.message }, status: :internal_server_error }
      end
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

    # def search_params
    #   params.fetch(:q, {}).permit(:earring_cont, :key_num_key_eq)
    # end
end
