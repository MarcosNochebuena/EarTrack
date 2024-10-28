class KeysController < ApplicationController
  before_action :set_key, only: %i[ show edit update destroy ]

  # GET /keys or /keys.json
  def index
    search_params = params.permit(:format, :page, q: [:num_key_cont, :upp_cont])
    @q = Key.ransack(params[:q])
    keys = @q.result(distinct: true).order(created_at: :asc)
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
        format.html { redirect_to key_url(@key), notice: "Key was successfully created." }
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
        format.html { redirect_to key_url(@key), notice: "Key was successfully updated." }
        format.json { render :show, status: :ok, location: @key }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keys/1 or /keys/1.json
  def destroy
    @key.destroy

    respond_to do |format|
      format.html { redirect_to keys_url, notice: "Key was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_key
      @key = Key.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def key_params
      params.require(:key).permit(:num_key, :upp)
    end
end
