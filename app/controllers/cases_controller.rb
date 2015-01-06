class CasesController < ApplicationController
	before_action :authenticate_user!

	def show
		@case = Case.find_by(CaseNumber: params['CaseNumber'])
	end
end
