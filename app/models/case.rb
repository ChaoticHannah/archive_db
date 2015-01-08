# Name: Case
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Class to process data from database Case table
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 01/06/2015 Created

class Case < ActiveRecord::Base
  extend DataTransfer

  self.primary_key = 'Id'

  belongs_to :user, primary_key: :AccountId, foreign_key: :account_id

  # returns hash with Case objects filtered by RecordTypeID
  def self.type_hash
    {
      'techline' => where(RecordTypeId: '012F0000000yFmQIAU'),
      'warranty' => where(RecordTypeId: '012F0000000zeudIAA'),
      'consumer affairs' => where(RecordTypeId: '012F0000000y9y7IAA')
    }
  end
end
