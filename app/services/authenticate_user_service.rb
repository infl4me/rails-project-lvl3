# frozen_string_literal: true

class AuthenticateUserService
  def call(info)
    User.find_or_create_by(email: info.email.downcase, name: info.name)
  end
end
