class BaseController < ApplicationController
  before_filter :check_security

  def save
    success = Info.save_procedure(params[:data])
    head 200 and return if success
    head 511
  end

  def select
    result = Info.select_procedure(select_params)
    head 404 and return unless result.present?
    render text: result
  end

  private

  def select_params
    params.permit(:limit, :offset, :account_id)
  end

  def check_security
    head 403 and return unless params[:key].present? &&
                               safe_key?
  end

  def safe_key?
    begin
      cipher = Gibberish::AES.new(CONFIG["aes_key"])
      true
      #CONFIG["#{params[:action]}_key"] == cipher.dec(params[:key])
    rescue OpenSSL::Cipher::CipherError
      false
    end
  end
end