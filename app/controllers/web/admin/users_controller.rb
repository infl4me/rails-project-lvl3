# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  # GET /categories
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page])
  end
end
