# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  # GET /admin/bulletins
  def index
    @bulletins = Bulletin.where(state: :under_moderation)
  end
end
