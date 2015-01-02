require 'csv'
require 'base64'

module DataTransfer
  def select_data_from_db(limits)
    limit = limits[:limit].present? ? (limits[:limit].to_i) : 10
    offset = limits[:offset].present? ? (limits[:offset].to_i) : 0
    account_id = limits[:account_id]

    records = account_id.present? ? where(AccountId: account_id) : all

    info_array = records.offset(offset).limit(limit)

    csv_string = CSV.generate(headers: true) do |csv|
      csv << attribute_names
      info_array.each do |info|
        csv << info.attributes.values
      end
    end
    Base64.encode64(csv_string)
  end

  def save_data_to_db(encoded_data)
    decoded_data = Base64.decode64(encoded_data)
    csv = CSV.parse(decoded_data)
    headers = csv.shift
    csv.to_a.map! { |row| Hash[headers.zip(row)].symbolize_keys }
    
    csv.each do |data_chunk|
      create(data_chunk)
    end
  end
end