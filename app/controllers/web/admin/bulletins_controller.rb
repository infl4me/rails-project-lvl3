# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  # GET /categories
  def index
    @bulletins = Bulletin.all
  end
end
