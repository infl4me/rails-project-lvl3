# frozen_string_literal: true

if Rails.env.development?
  %w[development business ruby js job].each do |category|
    Category.create(name: category)
  end
end
