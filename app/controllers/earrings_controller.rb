# frozen_string_literal: true

class EarringsController < ApplicationController
  before_action :set_earring, only: %i[show edit update destroy]

  # GET /earrings or /earrings.json
  def index
    # @q = Earring.includes(:key).ransack(params[:q])
    # @pagy, @earrings = pagy(@q.result(distinct: true))

    params.permit(:format, :page, q: %i[earring_cont key_num_key_cont])
    @q = Earring.includes(:key).ransack(params[:q])
    earrings = @q.result.where(keys: { producer: current_user.producer }).order(created_at: :desc)
    @live_earrings_count = earrings.where(status: :live).count
    @pagy, @earrings = pagy_countless(earrings)
  end

  # GET /earrings/1 or /earrings/1.json
  def show; end

  # GET /earrings/new
  def new
    @earring = Earring.new
    key_id = params[:key_id]
    @keys = Key.all
    @earring.key_id = key_id if key_id
  end

  # GET /earrings/1/edit
  def edit; end

  # POST /earrings or /earrings.json
  def create
    @earring = Earring.new(earring_params)

    respond_to do |format|
      if @earring.save
        format.html { redirect_to earring_url(@earring), notice: t('earrings.messages.correct_create') }
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
        format.html { redirect_to earring_url(@earring), notice: t('earrings.messages.correct_update') }
        format.json { render :show, status: :ok, location: @earring }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @earring.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /earrings/1 or /earrings/1.json
  def destroy
    # Intentar eliminar el arete
    if @earring.destroy
      respond_to do |format|
        format.html { redirect_to earrings_path, notice: t('earrings.messages.correct_delete') }
        format.turbo_stream do
          flash_turbo_stream_with_notice(t('earrings.messages.correct_delete'), [turbo_stream.remove(@earring)])
        end
        format.json { head :no_content }
      end
    else
      # Si destroy devuelve false (por ejemplo, debido a callbacks)
      error_message = @earring.errors.full_messages.join(', ')
      error_message = t('earrings.errors.error') if error_message.blank?

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
      format.html { redirect_to earrings_path, alert: t('earrings.errors.not_found') }
      format.turbo_stream do
        flash_turbo_stream_with_alert(t('earrings.errors.not_found'))
      end
      format.json { head :not_found }
    end
  rescue StandardError => e
    # Para cualquier otro error inesperado
    respond_to do |format|
      format.html { redirect_to earrings_path, alert: t('earrings.errors.error_unexpected') }
      format.turbo_stream do
        flash_turbo_stream_with_alert(t('earrings.errors.error_unexpected'))
      end
      format.json { render json: { error: e.message }, status: :internal_server_error }
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
