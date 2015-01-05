class BaseController < ApplicationController
  before_filter :check_security
  before_filter :detect_class

  def save
    success = @class_name.save_procedure(params[:data])
    head 200 and return if success
    head 511
  end

  def select
    result = @class_name.select_procedure(select_params)
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

  def detect_class
    head 404 and return unless table_name = params[:table_name]
    @class_name = Object.const_get(table_name.capitalize)
  end
end