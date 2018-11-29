class SetLanguageController < ApplicationController
  # before_action :set_path, only: [:turkish, :english]

  def turkish
    I18n.locale = :tr
    respond_to do |format|
      format.html{set_session_and_redirect}
    end
  end

  def english
    I18n.locale = :en
    respond_to do |format|
      format.html{set_session_and_redirect}
    end
  end

  private

  def set_session_and_redirect
    session[:locale] = I18n.locale
    c_h = {controller: params[:cont], action: params[:act], locale: I18n.locale}
    c_h[:id] = params[:id] if params[:id].present?
    c_h[:user_id] = params[:category_friendly_id] if params[:category_friendly_id].present?
    c_h[:type_id] = params[:company_friendly_id] if params[:company_friendly_id].present?
    path = url_for c_h
    @path = get_response_path path, params
    redirect_to @path #Rails.application.routes.recognize_path(@path, :method => :get)
  rescue ActionController::RedirectError
    redirect_to root_url(I18n.locale)
  end

  def get_response_path p, params
    path = p
    if params.keys.size > 4
      check = ["action", "controller", "locale", "path", "subdomain", "act", "cont", "type_id", "user_id", "id", "host"]
      @add = ""
      params.keys.each do |k|
        unless check.include? k
          @add = @add.present? ? @add.concat("&#{k.to_s}=#{params[k]}") : "?#{k.to_s}=#{params[k]}"
        end
      end
    end
    path = path.concat(@add) if @add.present?
    path
  end

end