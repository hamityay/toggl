class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :set_devise_permitted_parameters, if: :devise_controller?

  protected

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def set_locale
    unless session[:locale].present?
      browser_locale = extract_locale_from_accept_language_header == "tr" ? "tr" : "en"
      I18n.locale = browser_locale || I18n.default_locale
      session[:locale] = browser_locale || I18n.locale
      Rails.application.routes.default_url_options[:locale] = I18n.locale
    end
  end

  def set_devise_permitted_parameters
    sign_up_attributes = %i[email password password_confirmation name surname username]
    sign_in_attributes = %i[email password password_confirmation remember_me]
    update_attributes = %i[email password password_confirmation current_password name surname username]
    devise_parameter_sanitizer.permit(:sign_up, keys: sign_up_attributes)
    devise_parameter_sanitizer.permit(:sign_in, keys: sign_in_attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: update_attributes)
  end
end
