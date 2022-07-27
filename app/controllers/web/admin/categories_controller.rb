# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('categories.notices.created')
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('categories.notices.updated')
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: t('categories.notices.destroyed')
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
