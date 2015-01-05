class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def safe_key?
    CONFIG["#{params[:action]}_key"] == Base64.decode64(params[:key])
  end
end
