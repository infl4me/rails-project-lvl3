# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :set_bulletin_instance,
                only: %i[show edit update destroy to_moderate publish reject archive]
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
      redirect_to @bulletin, notice: t('bulletins.notices.created')
    else
      render :new
    end
  end

  # PATCH/PUT /bulletins/1
  def update
    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('bulletins.notices.updated')
    else
      render :edit
    end
  end

  # DELETE /bulletins/1
  def destroy
    @bulletin.destroy
    redirect_to bulletins_url, notice: t('bulletins.notices.destroyed')
  end

  # POST /bulletins/1/to_moderate
  def to_moderate
    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      redirect_to profile_root_path, notice: t('bulletins.notices.under_moderation')
    else
      redirect_to profile_root_path, alert: t('bulletins.alerts.under_moderation')
    end
  end

  # POST /bulletins/1/publish
  def publish
    if @bulletin.may_publish?
      @bulletin.publish!
      redirect_to profile_root_path, notice: t('bulletins.notices.published')
    else
      redirect_to profile_root_path, alert: t('bulletins.alerts.published')
    end
  end

  # POST /bulletins/1/reject
  def reject
    if @bulletin.may_reject?
      @bulletin.reject!
      redirect_to profile_root_path, notice: t('bulletins.notices.rejected')
    else
      redirect_to profile_root_path, alert: t('bulletins.alerts.rejected')
    end
  end

  # POST /bulletins/1/archive
  def archive
    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_to profile_root_path, notice: t('bulletins.notices.archived')
    else
      redirect_to profile_root_path, alert: t('bulletins.alerts.archived')
    end
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
