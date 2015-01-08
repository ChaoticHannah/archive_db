# Name: UsersController
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Controller class to  retrieve and display data related
# to User
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 01/06/2015 Created

class UsersController < ApplicationController
  before_action :authenticate_user!

  # returns all current user's cases to Home page
  def home
    @cases = current_user.cases.type_hash
  end
end
