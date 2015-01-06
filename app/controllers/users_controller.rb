class UsersController < ApplicationController
  before_action :authenticate_user!

  def home
    @cases = current_user.cases.type_hash
  end
end
