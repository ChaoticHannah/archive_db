class Info < ActiveRecord::Base
  extend DataTransfer

  def self.save_procedure(encoded_data)
    return unless encoded_data
    save_data_to_db(encoded_data)
  end

  def self.select_procedure(data)
    return unless any?
    select_data_from_db(data)
  end
end