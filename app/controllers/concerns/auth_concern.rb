# frozen_string_literal: true

module AuthConcern
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    session.clear
  end

  def signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def verify_admin
    return if signed_in? && @current_user.admin

    redirect_to root_path, alert: t('errors.access_denied')
  end
end
