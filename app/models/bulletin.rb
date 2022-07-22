# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :image, attached: true,
                    content_type: %w[image/png image/jpg image/jpeg],
                    size: { less_than: 5.megabytes, message: 'is too large' }
end
