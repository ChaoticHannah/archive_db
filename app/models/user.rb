# Name: User
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Class to process data from database User table
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 01/06/2015 Created

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable,
         :authentication_keys => [:dealer_code]

  validates :dealer_code, presence: true

  has_many :cases, primary_key: :account_id, foreign_key: :AccountId
  has_many :comments, through: :cases

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if dealer_code = conditions.delete(:dealer_code)
      where(conditions).find_by(dealer_code: dealer_code)
    else
      where(conditions).first
    end
  end
end