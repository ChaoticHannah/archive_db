# Name: Task
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Class to process data from database Task table
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 12/26/2014 Created

class Task < ActiveRecord::Base
  extend DataTransfer

  self.primary_key = 'Id'
end