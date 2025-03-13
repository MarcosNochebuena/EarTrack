class KeysController < ApplicationController
  before_action :set_key, only: %i[ show edit update destroy ]

  # GET /keys or /keys.json
  def index
    # search_params = params.permit(:format, :page, q: [:num_key_cont, :upp_cont])
    @q = Key.ransack(params[:q])
    keys = @q.result.where(producer: current_user.producer).order(created_at: :desc)
    @keys_count = keys.count
    @pagy, @keys = pagy_countless(keys)
  end

  # GET /keys/1 or /keys/1.json
  def show
  end

  # GET /keys/new
  def new
    @key = Key.new
  end

  # GET /keys/1/edit
  def edit
  end

  # POST /keys or /keys.json
  def create
    @key = Key.new(key_params)

    respond_to do |format|
      if @key.save
        format.html { redirect_to key_url(@key), notice: t('keys.messages.correct_delete') }
        format.json { render :show, status: :created, location: @key }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keys/1 or /keys/1.json
  def update
    respond_to do |format|
      if @key.update(key_params)
        format.html { redirect_to key_url(@key), notice: t('keys.messages.correct_update') }
        format.json { render :show, status: :ok, location: @key }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keys/1 or /keys/1.json
  def destroy
    begin
      earrings_count = @key.earrings.count
      has_earrings = earrings_count > 0

      # Intentar eliminar la clave (y sus aretes asociados gracias a dependent: :destroy)
      if @key.destroy
        success_message = if has_earrings
                            t('keys.messages.correct_delete_with_earrings', count: earrings_count)
                          else
                            t('keys.messages.correct_delete')
                          end

        respond_to do |format|
          format.html { redirect_to keys_url, notice: success_message }
          format.turbo_stream do
            flash_turbo_stream_with_notice(success_message, [turbo_stream.remove(@key)])
          end
          format.json { head :no_content }
        end
      else
        # Si destroy devuelve false (por ejemplo, debido a callbacks)
        error_message = @key.errors.full_messages.join(", ")
        error_message = t('keys.errors.error') if error_message.blank?

        respond_to do |format|
          format.html { redirect_to keys_url, alert: error_message }
          format.turbo_stream do
            flash_turbo_stream_with_alert(error_message)
          end
          format.json { render json: { error: error_message }, status: :unprocessable_entity }
        end
      end
    rescue ActiveRecord::RecordNotFound
      # Si la clave ya fue eliminada o no existe
      respond_to do |format|
        format.html { redirect_to keys_url, alert: t('keys.errors.not_found') }
        format.turbo_stream do
          flash_turbo_stream_with_alert(t('keys.errors.not_found'))
        end
        format.json { head :not_found }
      end
    rescue StandardError => e
      # Para cualquier otro error inesperado
      respond_to do |format|
        format.html { redirect_to keys_url, alert: t('keys.errors.error_unexpected') }
        format.turbo_stream do
          flash_turbo_stream_with_alert(t('keys.errors.error_unexpected'))
        end
        format.json { render json: { error: e.message }, status: :internal_server_error }
      end
    end
  end

  # GET /keys/1/check_associations
  def check_associations
    @key = Key.find(params[:id])
    has_associations = @key.earrings.exists?

    respond_to do |format|
      format.json { render json: { has_associations: has_associations, count: @key.earrings.count } }
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { error: t('keys.errors.not_found') }, status: :not_found }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_key
      @key = Key.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def key_params
      params.require(:key).permit(:num_key, :upp, :producer_id)
    end
end
