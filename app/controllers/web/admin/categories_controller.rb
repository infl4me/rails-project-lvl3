# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  # GET /admin/categories
  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result.page(params[:page])
  end
end
