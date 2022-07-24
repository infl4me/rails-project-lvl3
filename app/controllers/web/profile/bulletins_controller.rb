# frozen_string_literal: true

class Web::Profile::BulletinsController < Web::Profile::ApplicationController
  # GET /categories
  def index
    @bulletins = current_user.bulletins
  end
end
