class BaseController < ApplicationController
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
    params.permit(:from, :to, :account_id)
  end
end