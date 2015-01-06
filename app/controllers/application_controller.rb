class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  def safe_key?
    CONFIG["#{params[:action]}_key"] == Base64.decode64(params[:key])
  end

  protected

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
