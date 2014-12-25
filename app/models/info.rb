require 'csv'
require 'base64'

class Info < ActiveRecord::Base
  def self.save_procedure(encoded_data)
    return unless encoded_data
    decoded_data = Base64.decode64(encoded_data)
    csv = CSV.parse(decoded_data)
    headers = csv.shift
    csv.to_a.map! { |row| Hash[headers.zip(row)].symbolize_keys }
    
    csv.each do |data_chunk|
      Info.create(data_chunk)
    end
  end

  def self.select_procedure(data)
    return unless Info.any?
    from = data[:from].present? ? (data[:from].to_i - 1) : 0
    to = data[:to].present? ? (data[:to].to_i - 1) : 20

    info_array = all.to_a[from..to]

    csv_string = CSV.generate(headers: true) do |csv|
      csv << Info.attribute_names
      info_array.each do |info|
        csv << info.attributes.values
      end
    end
    Base64.encode64(csv_string)
  end
end