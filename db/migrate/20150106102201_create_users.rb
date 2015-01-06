class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :dealer_code
      t.string :encrypted_password
      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      t.datetime :remember_created_at

      t.timestamps
    end
  end
end
