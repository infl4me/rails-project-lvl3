# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  # GET /admin/categories
  def index
    @categories = Category.all
  end
end
