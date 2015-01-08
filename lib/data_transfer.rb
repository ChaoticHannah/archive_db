# Name: DataTransfer
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Helper module to insert and select data from database
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 12/26/2013 Created

require 'csv'
require 'base64'

module DataTransfer
  ATTRIBUTES_TO_SELECT = %w(Id Description AccountId WhatId ActivityDate OwnerId LastModifiedDate)

  # Returns encoded in base64 list of records from database
  # represented in csv format.
  # Assepts parameters hash which can contain following keys:
  # offset, limit, account_id
  def select_data_from_db(limits)
    return unless any?
    limit = (limits[:limit].presence || 10).to_i
    offset = limits[:offset].presence.to_i
    account_id = limits[:account_id]

    records = account_id.present? ? where(AccountId: account_id) : all

    info_array = records.offset(offset).limit(limit)

    csv_string = CSV.generate(headers: true) do |csv|
      csv << ATTRIBUTES_TO_SELECT

      info_array.each do |info|
        csv << info.attributes
                    .slice(*ATTRIBUTES_TO_SELECT)
                    .values
      end
    end
    Base64.encode64(csv_string)
  end

  # Receives encoded in base64 list of records represented in csv format and
  # saves then to database
  def save_data_to_db(encoded_data)
    return unless encoded_data
    decoded_data = Base64.decode64(encoded_data)
    csv = CSV.parse(decoded_data)
    headers = csv.shift
    csv.to_a.map! { |row| Hash[headers.zip(row)] }

    csv.each do |data_chunk|
      create(data_chunk.slice(*attribute_names).symbolize_keys)
    end
  end
end