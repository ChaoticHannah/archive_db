# Name: DataTransfer
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Helper module to insert and select data from database
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 12/26/2014 Created

require 'base64'
require 'csv'

module DataTransfer
  ATTRIBUTES_TO_SELECT = %w(Id Description AccountId WhatId ActivityDate OwnerId LastModifiedDate)

  # Returns encoded in base64 list of records from database
  # represented in csv format.
  # Assepts parameters hash which can contain following keys:
  # offset, limit, account_id
  def select_data_from_db(limits)
    return unless any?
    records_array = retrieve_records(limits)
    csv_string = convert_to_csv(records_array)
    Base64.encode64(csv_string)
  end

  # Receives encoded in base64 list of records represented in csv format and
  # saves then to database
  def save_data_to_db(encoded_data)
    return unless encoded_data
    decoded_data = Base64.decode64(encoded_data)
    csv = parse_csv(decoded_data)

    csv.each do |data_chunk|
      create(data_chunk.slice(*attribute_names).symbolize_keys)
    end
  end

  private
  # Parses data passed in csv format.
  # Returns array with object in hash representation
  def parse_csv(decoded_data)
    csv = CSV.parse(decoded_data)
    headers = csv.shift
    csv.to_a.map! { |row| Hash[headers.zip(row)] }
  end

  # Converts passed records intp csv format string
  def convert_to_csv(records_array)
    CSV.generate(headers: true) do |csv|
      csv << ATTRIBUTES_TO_SELECT

      records_array.each do |info|
        csv << info.attributes
                    .slice(*ATTRIBUTES_TO_SELECT)
                    .values
      end
    end
  end

  # Returns array of records according to passed conditions (limit, offset, account_id)
  def retrieve_records(limits)
    limit = (limits[:limit].presence || 10).to_i
    offset = limits[:offset].presence.to_i
    account_id = limits[:account_id]

    records = account_id.present? ? where(AccountId: account_id) : all

    records.offset(offset).limit(limit)
  end

  module_function :parse_csv, :convert_to_csv, :retrieve_records
end