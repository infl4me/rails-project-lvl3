# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  include BulletinControllerConcern
  before_action :set_bulletin_instance,
                only: %i[show edit update destroy to_moderate archive]
  before_action :set_bulletin, only: %i[index new create]

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.where(state: 'published').order(created_at: :desc).page(params[:page])
    @category_options = Category.all.pluck(:name, :id)
  end

  def show; end

  def new
    @bulletin = Bulletin.new
  end

  def edit; end

  def create
    @bulletin = Bulletin.new(bulletin_params.merge({ user: current_user }))

    if @bulletin.save
      redirect_to @bulletin, notice: t('bulletins.notices.created')
    else
      render :new
    end
  end

  def update
    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('bulletins.notices.updated')
    else
      render :edit
    end
  end

  def destroy
    @bulletin.destroy
    redirect_to profile_path, notice: t('bulletins.notices.destroyed')
  end

  def to_moderate
    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      redirect_to profile_path, notice: t('bulletins.notices.under_moderation')
    else
      redirect_to profile_path, alert: t('bulletins.alerts.under_moderation')
    end
  end

  def archive
    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_to profile_path, notice: t('bulletins.notices.archived')
    else
      redirect_to profile_path, alert: t('bulletins.alerts.archived')
    end
  end
end
