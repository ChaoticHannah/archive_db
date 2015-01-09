class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		found_case = Case.find_by(Id: params[:case_id])
		Comment.create(comments_params[:comment].merge(case_id: params[:case_id],
																					user: current_user))
		redirect_to show_case_path(found_case.CaseNumber, page: params[:page])
	end

	private

	def comments_params
		params.permit!
	end
end
