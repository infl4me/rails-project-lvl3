# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  # GET /categories
  def index
    @users = User.page(params[:page])
  end
end
