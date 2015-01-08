class Task < ActiveRecord::Base
  extend DataTransfer

  self.primary_key = 'Id'
end