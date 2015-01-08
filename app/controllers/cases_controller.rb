# Name: CasesController
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Controller class to  retrieve and display data related
# to Case
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 01/06/2015 Created

class CasesController < ApplicationController
  before_action :authenticate_user!

  # returns a single specific case found by its CaseNumber
  # to display in html page
  def show
    @case = Case.find_by(CaseNumber: params['CaseNumber'])
  end
end
