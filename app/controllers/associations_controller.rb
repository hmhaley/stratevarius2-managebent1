class AssociationsController < ApplicationController

	def new
		@association = Association.new
	end

	def create
		@association = Association.new(assoc_params)
		if @association.save
			redirect_to new_association_path
		end
	end

private

	def assoc_params
	params.require(:association).permit(
		:initiator_id, 
		:receiver_id,
		:assoc_type, 
		:initiator_comments_on_assoc, 
		:receiver_comments_on_assoc, 
	    :created_by_exec_id, 
		:confirmation_status_id,
		:start_date_month, 
		:start_date_year, 
		:end_date_month, 
		:end_date_year, 
		:is_verified_by_staff, 
		:is_verified_by_thirdparty, 	
		:staff_comments_on_assoc,
		confirmation_status_ids: [],
		)

	end

end