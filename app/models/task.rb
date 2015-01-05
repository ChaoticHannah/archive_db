class Task < ActiveRecord::Base
  self.primary_key = 'Id'

  extend DataTransfer

  def self.save_procedure(encoded_data)
    return unless encoded_data
    save_data_to_db(encoded_data)
  end

  def self.select_procedure(data)
    return unless any?
    select_data_from_db(data)
  end

  def self.aes256_cbc_encrypt
    cipher = Gibberish::AES.new(CONFIG["aes_key"])
    cipher.enc('=rJ!59vdkt!hfqUBi;|Y')
  end 
end