# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  include BulletinControllerConcern
  before_action :set_bulletin,
                only: %i[show edit update destroy to_moderate archive]

  def index
    authorize Bulletin

    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.where(state: 'published').order(created_at: :desc).page(params[:page])
    @category_options = Category.all.pluck(:name, :id)
  end

  def show
    authorize @bulletin
  end

  def new
    authorize Bulletin

    @bulletin = Bulletin.new
  end

  def edit
    authorize @bulletin
  end

  def create
    authorize Bulletin

    @bulletin = Bulletin.new(bulletin_params.merge({ user: current_user }))

    if @bulletin.save
      redirect_to @bulletin, notice: t('bulletins.notices.created')
    else
      render :new
    end
  end

  def update
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('bulletins.notices.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @bulletin

    @bulletin.destroy
    redirect_to profile_path, notice: t('bulletins.notices.destroyed')
  end

  def to_moderate
    authorize @bulletin

    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      redirect_to profile_path, notice: t('bulletins.notices.under_moderation')
    else
      redirect_to profile_path, alert: t('bulletins.alerts.under_moderation')
    end
  end

  def archive
    authorize @bulletin

    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_to profile_path, notice: t('bulletins.notices.archived')
    else
      redirect_to profile_path, alert: t('bulletins.alerts.archived')
    end
  end
end
