# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  def formatted_name
    name || email
  end
end
