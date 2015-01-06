class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :trackable, :rememberable,
         :authentication_keys => [:dealer_code]

  validates :dealer_code, presence: true

  has_many :cases, primary_key: :account_id, foreign_key: :AccountId

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if dealer_code = conditions.delete(:dealer_code)
      where(conditions).find_by(dealer_code: dealer_code)
    else
      where(conditions).first
    end
  end
end