# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  before_action :set_bulletin, only: %i[show edit update destroy]

  # GET /bulletins
  def index
    @bulletins = Bulletin.all.order(created_at: :desc)
  end

  # GET /bulletins/1
  def show; end

  # GET /bulletins/new
  def new
    @bulletin = Bulletin.new
  end

  # GET /bulletins/1/edit
  def edit; end

  # POST /bulletins
  def create
    # byebug
    @bulletin = Bulletin.new(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: 'Bulletin was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bulletins/1
  def update
    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: 'Bulletin was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bulletins/1
  def destroy
    @bulletin.destroy
    redirect_to bulletins_url, notice: 'Bulletin was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id, :user_id, :user_id)
  end
end
