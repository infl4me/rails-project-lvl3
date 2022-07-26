# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.where(state: :under_moderation).page(params[:page])
    @category_options = Category.all.pluck(:name, :id)
  end
end
