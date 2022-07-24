# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.all
  end

  def under_moderation
    @bulletins = Bulletin.where(state: :under_moderation)
  end
end
