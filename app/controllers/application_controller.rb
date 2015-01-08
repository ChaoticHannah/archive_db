# Name: ApplicationController
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Standart class that contains helper methods that can be
# accessed from every custom controller
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 12/25/2014 Created

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  # checks if given in request parameters sacurity key is valid
  def safe_key?
    CONFIG["#{params[:action]}_key"] == Base64.decode64(params[:key])
  end

  protected

  # configures parameters for Devise authentication
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:dealer_code,
                                                            :password,
                                                            :password_confirmation,
                                                            :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:dealer_code,
                                                            :password,
                                                            :remember_me) }
  end
end
