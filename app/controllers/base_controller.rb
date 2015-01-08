# Name: BaseController
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Controller class to perform insert(select) and save operations with database
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 12/25/2014 Created

class BaseController < ApplicationController
  before_filter :check_security
  before_filter :detect_class

  # saves data to database
  def save
    success = @class_name.save_data_to_db(params[:data])
    head 200 and return if success
    head 511
  end

  # retrieves data from database
  def select
    result = @class_name.select_data_from_db(select_params)
    head 404 and return unless result.present?
    render text: result
  end

  private

  # filters parameters to base_controller#select method
  def select_params
    params.permit(:limit, :offset, :account_id)
  end

  # checks for security key
  def check_security
    head 403 and return unless params[:key].present? &&
                               safe_key?
  end

  # determine table to which data will be inserted or retrieved from
  def detect_class
    head 404 and return unless table_name = params[:table_name]
    @class_name = Object.const_get(table_name.capitalize)
  end
end