# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  # GET /categories
  def index
    @bulletins = Bulletin.where(state: :under_moderation)
  end
end
