# frozen_string_literal: true

module BulletinControllerConcern
  extend ActiveSupport::Concern

  included do
    after_action :verify_authorized
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
