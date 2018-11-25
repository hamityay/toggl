class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_devise_permitted_parameters, if: :devise_controller?

  protected

  def set_devise_permitted_parameters
    sign_up_attributes = %i[email password password_confirmation name surname username]
    sign_in_attributes = %i[email password password_confirmation remember_me]
    update_attributes = %i[email password password_confirmation current_password name surname username]
    devise_parameter_sanitizer.permit(:sign_up, keys: sign_up_attributes)
    devise_parameter_sanitizer.permit(:sign_in, keys: sign_in_attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: update_attributes)
  end
end
