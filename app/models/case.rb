class Case < ActiveRecord::Base
  extend DataTransfer

  self.primary_key = 'Id'

  belongs_to :user, primary_key: :AccountId, foreign_key: :account_id

  def self.type_hash
    {
      'techline' => where(RecordTypeId: '012F0000000yFmQIAU'),
      'warranty' => where(RecordTypeId: '012F0000000zeudIAA'),
      'consumer affairs' => where(RecordTypeId: '012F0000000y9y7IAA')
    }
  end
end
