# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    info = request.env['omniauth.auth'][:info]
    email = info[:email].downcase
    name = info[:name]

    user = User.find_by(email: email) || User.create(email: email, name: name)
    sign_in user

    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
