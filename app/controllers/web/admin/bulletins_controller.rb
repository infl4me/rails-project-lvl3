# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  include BulletinControllerConcern
  before_action :set_bulletin_instance,
                only: %i[publish reject archive]
  before_action :set_bulletin, only: %i[index]

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.where(state: :under_moderation).page(params[:page])
    @category_options = Category.all.pluck(:name, :id)
  end

  def publish
    if @bulletin.may_publish?
      @bulletin.publish!
      redirect_to admin_root_path, notice: t('bulletins.notices.published')
    else
      redirect_to admin_root_path, alert: t('bulletins.alerts.published')
    end
  end

  def reject
    if @bulletin.may_reject?
      @bulletin.reject!
      redirect_to admin_root_path, notice: t('bulletins.notices.rejected')
    else
      redirect_to admin_root_path, alert: t('bulletins.alerts.rejected')
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
