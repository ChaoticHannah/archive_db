require 'csv'
require 'base64'

module DataTransfer
  def select_data_from_db(limits)
    from = limits[:from].present? ? (limits[:from].to_i - 1) : 0
    to = limits[:to].present? ? (limits[:to].to_i - 1) : 20

    info_array = all.to_a[from..to]

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