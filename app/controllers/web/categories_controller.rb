# frozen_string_literal: true

class Web::CategoriesController < Web::ApplicationController
  before_action :verify_admin
  before_action :set_category, only: %i[edit update destroy]

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('categories.notices.created')
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('categories.notices.updated')
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: t('categories.notices.destroyed')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name)
  end
end
