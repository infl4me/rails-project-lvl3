# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :set_bulletin_instance, only: %i[show edit update destroy]
  before_action :set_bulletin, only: %i[index new create]
  after_action :verify_authorized

  # GET /bulletins
  def index
    @bulletins = Bulletin.where(state: 'published').order(created_at: :desc)
  end

  # GET /bulletins/1
  def show; end

  # GET /bulletins/new
  def new
    authorize Bulletin
    @bulletin = Bulletin.new
  end

  # GET /bulletins/1/edit
  def edit; end

  # POST /bulletins
  def create
    @bulletin = Bulletin.new(bulletin_params.merge({ user: current_user }))

    if @bulletin.save
      redirect_to @bulletin, notice: t('bulletins.notice.created')
    else
      render :new
    end
  end

  # PATCH/PUT /bulletins/1
  def update
    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('bulletins.notice.updated')
    else
      render :edit
    end
  end

  # DELETE /bulletins/1
  def destroy
    @bulletin.destroy
    redirect_to bulletins_url, notice: t('bulletins.notice.destroyed')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bulletin_instance
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def set_bulletin
    authorize Bulletin
  end

  # Only allow a list of trusted parameters through.
  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
